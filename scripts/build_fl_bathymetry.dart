// Builds the bundled FL bathymetry tile set consumed by
// `BundledBathymetryAdapter`.
//
// Source: GMRT GridServer (https://www.gmrt.org/services/GridServer).
// GMRT auto-blends the best public bathymetry per cell — BlueTopo
// (~16 m) where NOAA has it for the FL coast, NCEI CRM (~90 m)
// elsewhere on the shelf, GEBCO offshore. One clean API, NOAA-grade.
//
// Output: `assets/bathymetry/fl/{N|S}lat_{E|W}lon.bin.gz` (one gzipped
// 1°×1° tile per ocean-bearing cell) plus `manifest.json`. Binary tile
// layout is documented in `lib/data/sources/bundled_bathymetry/
// bathymetry_tile.dart`.
//
// Run from the repo root:
//   fvm dart run scripts/build_fl_bathymetry.dart
//
// It's network-heavy (tens of MB across ~30 tiles) and resumable —
// tiles whose output already exists are skipped, so a flaky run can
// just be re-invoked. Re-run annually to refresh as GMRT ingests new
// NOAA surveys.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// FL bounding box, integer-degree SW tile corners.
const int _latMin = 24; // 24°N (Keys) ..
const int _latMax = 30; // .. 30°N (FL/GA line) — tile covers [lat, lat+1)
const int _lonMin = -88; // 88°W (E Gulf) ..
const int _lonMax = -80; // .. 80°W (Atlantic, offshore Gulf Stream)

// 3 arc-sec ≈ 90 m. 1° / 1200 cells.
const int _cellsPerSide = 1200;
const double _cellSizeDeg = 1.0 / 1200.0;
const int _nodata = -32768;

const String _outDir = 'assets/bathymetry/fl';
const String _gmrt = 'https://www.gmrt.org/services/GridServer';

Future<void> main() async {
  final dir = Directory(_outDir);
  if (!dir.existsSync()) dir.createSync(recursive: true);

  final present = <Map<String, int>>[];
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 60);

  for (var lat = _latMin; lat <= _latMax; lat++) {
    for (var lon = _lonMin; lon <= _lonMax; lon++) {
      final name = '${_latTag(lat)}_${_lonTag(lon)}';
      final outPath = '$_outDir/$name.bin.gz';
      if (File(outPath).existsSync()) {
        stdout.writeln('skip  $name (exists)');
        present.add({'lat': lat, 'lon': lon});
        continue;
      }
      stdout.write('fetch $name … ');
      try {
        final grid = await _fetchGmrtAscii(client, lat, lon);
        final tile = _resample(grid, lat.toDouble(), lon.toDouble());
        if (!_hasOcean(tile)) {
          stdout.writeln('all land/empty — skipped');
          continue;
        }
        final blob = _encodeTile(tile, lat.toDouble(), lon.toDouble());
        File(outPath).writeAsBytesSync(gzip.encode(blob));
        present.add({'lat': lat, 'lon': lon});
        stdout
            .writeln('ok (${(File(outPath).lengthSync() / 1024).round()} KB)');
      } catch (e) {
        stdout.writeln('FAILED: $e');
      }
    }
  }
  client.close();

  final manifest = <String, Object?>{
    'version': 1,
    'tileDir': _outDir,
    'cellsPerSide': _cellsPerSide,
    'cellSizeDeg': _cellSizeDeg,
    'nodata': _nodata,
    'tiles': present,
  };
  File('$_outDir/manifest.json')
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(manifest));
  stdout.writeln('\nwrote manifest with ${present.length} tiles → $_outDir');
}

String _latTag(int lat) => lat >= 0 ? 'N$lat' : 'S${-lat}';
String _lonTag(int lon) => lon >= 0 ? 'E$lon' : 'W${-lon}';

/// Fetches a 1°×1° ESRI-ASCII grid from GMRT at the finest resolution
/// it'll serve for the span. Returns (ncols, nrows, xll, yll, cell,
/// nodata, values[row-major, row0=north]).
Future<_AsciiGrid> _fetchGmrtAscii(
  HttpClient client,
  int lat,
  int lon,
) async {
  final uri = Uri.parse(_gmrt).replace(
    queryParameters: {
      'minlongitude': '$lon',
      'maxlongitude': '${lon + 1}',
      'minlatitude': '$lat',
      'maxlatitude': '${lat + 1}',
      'format': 'esriascii',
      'resolution': 'max',
    },
  );
  final req = await client.getUrl(uri);
  final resp = await req.close();
  if (resp.statusCode != 200) {
    throw HttpException('GMRT ${resp.statusCode} for $uri');
  }
  final body = await resp.transform(utf8.decoder).join();
  return _parseAscii(body);
}

class _AsciiGrid {
  _AsciiGrid(
    this.ncols,
    this.nrows,
    this.xll,
    this.yll,
    this.cell,
    this.nodata,
    this.v,
  );
  final int ncols;
  final int nrows;
  final double xll;
  final double yll;
  final double cell;
  final double nodata;
  final Float64List v; // row 0 = north
}

_AsciiGrid _parseAscii(String body) {
  final tokens = body.split(RegExp(r'\s+')).where((t) => t.isNotEmpty);
  final it = tokens.iterator;
  String next() {
    if (!it.moveNext()) throw const FormatException('ESRI ASCII truncated');
    return it.current;
  }

  int ncols = 0, nrows = 0;
  double xll = 0, yll = 0, cell = 0, nodata = -9999;
  // Header is six "key value" pairs in any order.
  for (var i = 0; i < 6; i++) {
    final key = next().toLowerCase();
    final val = next();
    switch (key) {
      case 'ncols':
        ncols = int.parse(val);
      case 'nrows':
        nrows = int.parse(val);
      case 'xllcorner':
        xll = double.parse(val);
      case 'yllcorner':
        yll = double.parse(val);
      case 'cellsize':
        cell = double.parse(val);
      case 'nodata_value':
        nodata = double.parse(val);
      default:
        throw FormatException('Unexpected ESRI ASCII header key: $key');
    }
  }
  final v = Float64List(ncols * nrows);
  for (var i = 0; i < v.length; i++) {
    v[i] = double.parse(next());
  }
  return _AsciiGrid(ncols, nrows, xll, yll, cell, nodata, v);
}

/// Nearest-neighbour resample of [g] onto our fixed 1200×1200 grid for
/// the tile whose SW corner is ([tileLon], [tileLat]). Output row 0 =
/// north edge, metres as int16 (clamped), [_nodata] off-grid/no-data.
Int16List _resample(_AsciiGrid g, double tileLat, double tileLon) {
  final out = Int16List(_cellsPerSide * _cellsPerSide)
    ..fillRange(0, _cellsPerSide * _cellsPerSide, _nodata);
  final northLat = tileLat + 1.0;
  for (var row = 0; row < _cellsPerSide; row++) {
    // Cell-centre latitude for this output row (north → south).
    final cellLat = northLat - (row + 0.5) * _cellSizeDeg;
    final srcRow = ((g.yll + g.nrows * g.cell - cellLat) / g.cell).floor();
    if (srcRow < 0 || srcRow >= g.nrows) continue;
    for (var col = 0; col < _cellsPerSide; col++) {
      final cellLon = tileLon + (col + 0.5) * _cellSizeDeg;
      final srcCol = ((cellLon - g.xll) / g.cell).floor();
      if (srcCol < 0 || srcCol >= g.ncols) continue;
      final s = g.v[srcRow * g.ncols + srcCol];
      if (s == g.nodata || s.isNaN) continue;
      final m = s.round().clamp(-32767, 32767);
      out[row * _cellsPerSide + col] = m;
    }
  }
  return out;
}

bool _hasOcean(Int16List tile) {
  for (final v in tile) {
    if (v != _nodata && v < 0) return true;
  }
  return false;
}

Uint8List _encodeTile(Int16List data, double swLat, double swLon) {
  const header = 34;
  final bytes = Uint8List(header + data.length * 2);
  final bd = ByteData.sublistView(bytes);
  bd.setUint32(0, 0x54424C46, Endian.little); // 'FLBT'
  bd.setUint16(4, 1, Endian.little); // version
  bd.setUint16(6, _cellsPerSide, Endian.little);
  bd.setFloat64(8, swLat, Endian.little);
  bd.setFloat64(16, swLon, Endian.little);
  bd.setFloat64(24, _cellSizeDeg, Endian.little);
  bd.setInt16(32, _nodata, Endian.little);
  for (var i = 0; i < data.length; i++) {
    bd.setInt16(header + i * 2, data[i], Endian.little);
  }
  return bytes;
}

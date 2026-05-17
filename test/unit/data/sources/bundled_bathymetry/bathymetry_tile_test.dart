import 'dart:typed_data';

import 'package:ai_marine_engine/data/sources/bundled_bathymetry/bathymetry_tile.dart';
import 'package:flutter_test/flutter_test.dart';

/// Encodes a synthetic tile in the exact layout
/// `scripts/build_fl_bathymetry.dart` produces. [data] is row-major,
/// row 0 = north edge.
Uint8List encodeTile({
  required int side,
  required double swLat,
  required double swLon,
  required double cell,
  required int nodata,
  required List<int> data,
}) {
  const header = 34;
  final bytes = Uint8List(header + data.length * 2);
  final bd = ByteData.sublistView(bytes);
  bd.setUint32(0, 0x54424C46, Endian.little); // 'FLBT'
  bd.setUint16(4, 1, Endian.little);
  bd.setUint16(6, side, Endian.little);
  bd.setFloat64(8, swLat, Endian.little);
  bd.setFloat64(16, swLon, Endian.little);
  bd.setFloat64(24, cell, Endian.little);
  bd.setInt16(32, nodata, Endian.little);
  for (var i = 0; i < data.length; i++) {
    bd.setInt16(header + i * 2, data[i], Endian.little);
  }
  return bytes;
}

// 2×2 tile, SW corner (28°N, 81°W), 0.5° cells → covers
// lat [28,29), lon [-81,-80). Row 0 = north band, row 1 = south.
//   NW=-10 m (32.8 ft)   NE=-100 m (328 ft)
//   SW=+5 m (land)       SE=nodata
Uint8List _tile({int nodata = -32768}) => encodeTile(
      side: 2,
      swLat: 28,
      swLon: -81,
      cell: 0.5,
      nodata: nodata,
      data: [-10, -100, 5, nodata],
    );

void main() {
  group('BathymetryTile.parse', () {
    test('round-trips header fields', () {
      final t = BathymetryTile.parse(_tile());
      expect(t.cellsPerSide, 2);
      expect(t.swLat, 28);
      expect(t.swLon, -81);
      expect(t.cellSizeDeg, 0.5);
      expect(t.nodata, -32768);
    });

    test('rejects a bad magic', () {
      final bytes = _tile();
      bytes[0] = 0x00; // corrupt magic
      expect(
        () => BathymetryTile.parse(bytes),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects an unsupported version', () {
      final bytes = _tile();
      ByteData.sublistView(bytes).setUint16(4, 99, Endian.little);
      expect(
        () => BathymetryTile.parse(bytes),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects a truncated body', () {
      final full = _tile();
      final short = full.sublist(0, full.length - 2);
      expect(
        () => BathymetryTile.parse(short),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('BathymetryTile.covers', () {
    final t = BathymetryTile.parse(_tile());

    test('inside the 1°-ish footprint', () {
      expect(t.covers(28.5, -80.5), isTrue);
      expect(t.covers(28.0, -81.0), isTrue); // SW corner inclusive
    });

    test('outside the footprint', () {
      expect(t.covers(29.0, -80.5), isFalse); // north edge exclusive
      expect(t.covers(28.5, -80.0), isFalse); // east edge exclusive
      expect(t.covers(40, -70), isFalse);
    });
  });

  group('BathymetryTile.depthFtAt', () {
    final t = BathymetryTile.parse(_tile());

    test('north band reads as the NW/NE rows (row 0 = north)', () {
      // lat 28.75 → row 0; lon -80.75 → col 0 (NW = -10 m).
      expect(t.depthFtAt(28.75, -80.75), closeTo(32.808, 1e-2));
      // lon -80.25 → col 1 (NE = -100 m).
      expect(t.depthFtAt(28.75, -80.25), closeTo(328.084, 1e-2));
    });

    test('land cell (elevation ≥ 0) returns null', () {
      // lat 28.25 → row 1; lon -80.75 → col 0 (SW = +5 m, land).
      expect(t.depthFtAt(28.25, -80.75), isNull);
    });

    test('nodata cell returns null', () {
      // lat 28.25 → row 1; lon -80.25 → col 1 (SE = nodata).
      expect(t.depthFtAt(28.25, -80.25), isNull);
    });

    test('point outside the tile returns null', () {
      expect(t.depthFtAt(40, -70), isNull);
    });
  });
}

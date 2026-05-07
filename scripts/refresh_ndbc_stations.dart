/// Refresh `assets/ndbc_stations.json` from the live NOAA NDBC active-
/// station feed, filtered to the v1 Florida coverage bbox.
///
/// Run with: `fvm dart run scripts/refresh_ndbc_stations.dart`
///
/// Why a script and not live-fetch at startup: the station list barely
/// changes — new stations come online every few months, retired ones
/// drop out. Bundling a snapshot keeps the app offline-first and
/// removes a network dependency from cold start. Run this script
/// before each release to keep the snapshot fresh.
library;

import 'dart:convert';
import 'dart:io';

/// Inclusive bbox for v1 Florida coverage. South to the Keys, north to
/// the Florida–Georgia line + a few miles into Georgia for nearshore
/// stations like Grays Reef. West to Mobile Bay (Pensacola panhandle
/// fish like the same Gulf), east to ~250 nm offshore so the major
/// open-water Atlantic buoys (41010 etc.) are included.
const _minLat = 24.0;
const _maxLat = 31.5;
const _minLon = -88.0;
const _maxLon = -78.0;

const _feedUrl = 'https://www.ndbc.noaa.gov/activestations.xml';
const _outputPath = 'assets/ndbc_stations.json';

/// Station "types" we care about for the chart marker layer. `buoy` and
/// `fixed` (C-MAN coastal stations) report meteorology and waves and
/// are the ones useful to anglers. We drop `dart` (deep-ocean tsunami
/// warning), `tao` (tropical Pacific), `usv` (autonomous surface
/// vehicles), and `other`.
const _allowedTypes = {'buoy', 'fixed'};

Future<void> main() async {
  stdout.writeln('Fetching $_feedUrl …');
  final xml = await _fetch(_feedUrl);

  final stations = _parseStations(xml)
      .where((s) => _allowedTypes.contains(s.type))
      .where((s) => _inBbox(s.lat, s.lon))
      .toList()
    ..sort((a, b) => a.id.compareTo(b.id));

  stdout.writeln(
    'Filtered to ${stations.length} stations inside '
    '($_minLat..$_maxLat, $_minLon..$_maxLon).',
  );

  final json = const JsonEncoder.withIndent('  ').convert({
    'schemaVersion': '1.0',
    '_comment':
        'NDBC active stations within v1 Florida coverage bbox. Generated '
            'by scripts/refresh_ndbc_stations.dart from $_feedUrl. '
            'Re-run before each release.',
    '_generatedAt': DateTime.now().toUtc().toIso8601String(),
    '_bbox': {
      'minLat': _minLat,
      'maxLat': _maxLat,
      'minLon': _minLon,
      'maxLon': _maxLon,
    },
    'stations': [
      for (final s in stations)
        {
          'id': s.id,
          'name': s.name,
          'lat': s.lat,
          'lon': s.lon,
        },
    ],
  });

  await File(_outputPath).writeAsString('$json\n');
  stdout.writeln('Wrote $_outputPath');
}

Future<String> _fetch(String url) async {
  final client = HttpClient();
  try {
    final req = await client.getUrl(Uri.parse(url));
    final res = await req.close();
    if (res.statusCode != 200) {
      throw HttpException('GET $url returned ${res.statusCode}');
    }
    return await res.transform(utf8.decoder).join();
  } finally {
    client.close();
  }
}

/// Each station is a self-closing `<station ... />` element with
/// double-quoted attributes. The feed is large (~1300 stations) but
/// regular and well-formed so a regex pull avoids dragging in an XML
/// parser dependency for a one-off script.
Iterable<_Station> _parseStations(String xml) sync* {
  final stationPattern = RegExp(r'<station\s([^/>]+)/>');
  final attrPattern = RegExp(r'(\w+)="([^"]*)"');
  for (final match in stationPattern.allMatches(xml)) {
    final attrs = <String, String>{};
    for (final a in attrPattern.allMatches(match.group(1)!)) {
      attrs[a.group(1)!] = a.group(2)!;
    }
    final id = attrs['id'];
    final lat = double.tryParse(attrs['lat'] ?? '');
    final lon = double.tryParse(attrs['lon'] ?? '');
    final name = attrs['name'];
    final type = attrs['type'];
    if (id == null ||
        lat == null ||
        lon == null ||
        name == null ||
        type == null) {
      continue;
    }
    yield _Station(id: id, name: name, lat: lat, lon: lon, type: type);
  }
}

bool _inBbox(double lat, double lon) =>
    lat >= _minLat && lat <= _maxLat && lon >= _minLon && lon <= _maxLon;

class _Station {
  _Station({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.type,
  });

  final String id;
  final String name;
  final double lat;
  final double lon;
  final String type;
}

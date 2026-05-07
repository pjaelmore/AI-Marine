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

/// Inclusive bbox for v1 Florida coverage. Roomy on every side so we
/// catch the relevant neighbours: south past the Keys to ~Dry
/// Tortugas; north a buffer over the FL–GA line for Grays Reef-type
/// nearshore Atlantic stations; west to the central Gulf so the deep-
/// water buoys (42001/42002/42003) and the LA/MS coast stations panhandle
/// anglers care about are included; east to ~400 nm offshore for the
/// open-Atlantic ring (41010 etc.).
const _minLat = 22.0;
const _maxLat = 32.0;
const _minLon = -92.0;
const _maxLon = -76.0;

const _feedUrl = 'https://www.ndbc.noaa.gov/activestations.xml';
const _outputPath = 'assets/ndbc_stations.json';

/// Station "types" we care about for the chart marker layer. `buoy`
/// is the canonical offshore platform; `fixed` covers C-MAN coastal
/// stations (lighthouses, piers); `other` catches operational stations
/// NDBC hasn't fully categorised that still report meteorology.
/// Excluded: `dart` (deep-ocean tsunami warning, mid-ocean), `tao`
/// (tropical Pacific array), `usv` (autonomous surface vehicles —
/// transient and irrelevant to a static angler).
const _allowedTypes = {'buoy', 'fixed', 'other'};

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

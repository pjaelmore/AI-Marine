import 'package:ai_marine_engine/data/sources/open_meteo_marine/open_meteo_marine_parser.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _body({
  required List<String> times,
  required List<num?> temps,
}) {
  return {
    'latitude': 28.5,
    'longitude': -80.0,
    'hourly_units': {
      'time': 'iso8601',
      'sea_surface_temperature': '°C',
    },
    'hourly': {
      'time': times,
      'sea_surface_temperature': temps,
    },
  };
}

void main() {
  group('parseOpenMeteoSeaSurfaceTemp', () {
    test('returns the sample at the exact target hour', () {
      final r = parseOpenMeteoSeaSurfaceTemp(
        _body(
          times: ['2026-05-16T18:00', '2026-05-16T19:00', '2026-05-16T20:00'],
          temps: [27.0, 27.5, 28.0],
        ),
        DateTime.utc(2026, 5, 16, 19),
      );
      expect(r.tempC, 27.5);
    });

    test('picks the closest hour when the target is mid-bucket', () {
      // Target 19:20 → 19:00 is 20 min away, 20:00 is 40 min away.
      // Closest sample wins.
      final r = parseOpenMeteoSeaSurfaceTemp(
        _body(
          times: ['2026-05-16T18:00', '2026-05-16T19:00', '2026-05-16T20:00'],
          temps: [27.0, 27.5, 28.0],
        ),
        DateTime.utc(2026, 5, 16, 19, 20),
      );
      expect(r.tempC, 27.5);
    });

    test('skips null samples (past forecast horizon or QC-rejected)', () {
      // The bucket nearest 12:00 is 12:00 itself, but it's null —
      // should fall back to the next-nearest non-null hour.
      final r = parseOpenMeteoSeaSurfaceTemp(
        _body(
          times: ['2026-05-16T11:00', '2026-05-16T12:00', '2026-05-16T13:00'],
          temps: [26.8, null, 27.1],
        ),
        DateTime.utc(2026, 5, 16, 12),
      );
      // 11:00 and 13:00 are equidistant; first encountered wins (11:00).
      expect(r.tempC, 26.8);
    });

    test('returns the picked bucket time as observedAt (UTC)', () {
      final r = parseOpenMeteoSeaSurfaceTemp(
        _body(
          times: ['2026-05-16T18:00', '2026-05-16T19:00'],
          temps: [27.0, 27.5],
        ),
        DateTime.utc(2026, 5, 16, 19),
      );
      expect(r.observedAt.toUtc(), DateTime.utc(2026, 5, 16, 19));
    });

    test('throws when `hourly` block is missing', () {
      expect(
        () => parseOpenMeteoSeaSurfaceTemp(
          {'latitude': 28.5, 'longitude': -80.0},
          DateTime.utc(2026, 5, 16, 18),
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws when time and temp array lengths diverge', () {
      expect(
        () => parseOpenMeteoSeaSurfaceTemp(
          _body(
            times: ['2026-05-16T18:00', '2026-05-16T19:00'],
            temps: [27.0],
          ),
          DateTime.utc(2026, 5, 16, 18),
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws when every sample is null (no usable data)', () {
      expect(
        () => parseOpenMeteoSeaSurfaceTemp(
          _body(
            times: ['2026-05-16T18:00', '2026-05-16T19:00'],
            temps: [null, null],
          ),
          DateTime.utc(2026, 5, 16, 18),
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws when the hourly arrays are empty', () {
      expect(
        () => parseOpenMeteoSeaSurfaceTemp(
          _body(times: [], temps: []),
          DateTime.utc(2026, 5, 16, 18),
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}

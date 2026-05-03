import 'package:ai_marine_engine/data/sources/nws_forecast/wind_string_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseNwsWind — single-value forms', () {
    test('"10 mph" parses to ~8.7 kt with no gusts', () {
      final wind = parseNwsWind('10 mph', 'NW');
      expect(wind, isNotNull);
      expect(wind!.speedKnots, closeTo(8.69, 0.01));
      expect(wind.gustsKnots, isNull);
      expect(wind.directionDegrees, 315);
    });

    test('"15 kt" passes through unchanged in knots', () {
      final wind = parseNwsWind('15 kt', 'S');
      expect(wind!.speedKnots, closeTo(15, 1e-9));
      expect(wind.directionDegrees, 180);
    });

    test('"10 km/h" converts to ~5.4 kt', () {
      final wind = parseNwsWind('10 km/h', 'E');
      expect(wind!.speedKnots, closeTo(5.4, 0.01));
    });

    test('a bare integer with no unit defaults to mph', () {
      final wind = parseNwsWind('20', 'N');
      expect(wind!.speedKnots, closeTo(20 * 0.86898, 0.01));
    });
  });

  group('parseNwsWind — range forms', () {
    test('"10 to 14 mph" averages to ~10.4 kt with gusts at 14 mph (~12.2 kt)',
        () {
      final wind = parseNwsWind('10 to 14 mph', 'SW');
      expect(wind!.speedKnots, closeTo(12 * 0.86898, 0.01));
      expect(wind.gustsKnots, closeTo(14 * 0.86898, 0.01));
      expect(wind.directionDegrees, 225);
    });

    test('"10 to 14 kt" stays in knots; midpoint = 12 kt', () {
      final wind = parseNwsWind('10 to 14 kt', 'SW');
      expect(wind!.speedKnots, closeTo(12, 1e-9));
      expect(wind.gustsKnots, closeTo(14, 1e-9));
    });
  });

  group('parseNwsWind — degenerate inputs', () {
    test('"calm" parses to null (engine suppresses the wind modifier)', () {
      expect(parseNwsWind('calm', 'N'), isNull);
      expect(parseNwsWind('Calm', ''), isNull);
    });

    test('empty speed string parses to null', () {
      expect(parseNwsWind('', 'N'), isNull);
    });

    test('unparseable speed string parses to null', () {
      expect(parseNwsWind('blowin\' a hooley', 'NW'), isNull);
    });

    test('empty / unknown direction defaults to 0° (N)', () {
      expect(parseNwsWind('5 mph', '')!.directionDegrees, 0);
      expect(parseNwsWind('5 mph', '???')!.directionDegrees, 0);
    });
  });

  group('compassAbbreviationToDegrees', () {
    test('all 16 compass points round-trip cleanly', () {
      const expectations = {
        'N': 0.0,
        'NNE': 22.5,
        'NE': 45.0,
        'ENE': 67.5,
        'E': 90.0,
        'ESE': 112.5,
        'SE': 135.0,
        'SSE': 157.5,
        'S': 180.0,
        'SSW': 202.5,
        'SW': 225.0,
        'WSW': 247.5,
        'W': 270.0,
        'WNW': 292.5,
        'NW': 315.0,
        'NNW': 337.5,
      };
      for (final entry in expectations.entries) {
        expect(
          compassAbbreviationToDegrees(entry.key),
          closeTo(entry.value, 1e-9),
          reason: entry.key,
        );
      }
    });

    test('lower-case is normalised', () {
      expect(compassAbbreviationToDegrees('sw'), 225);
    });
  });
}

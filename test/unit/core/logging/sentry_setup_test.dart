import 'package:ai_marine_engine/core/logging/sentry_setup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('stripPotentialPii', () {
    test('drops identifier-shaped keys regardless of case', () {
      final result = stripPotentialPii({
        'email': 'angler@example.com',
        'UserID': 42,
        'device_id': 'abc-123',
        'notes': 'caught one near my dock',
        'source': 'noaa_ndbc',
      });

      expect(result.keys, ['source']);
      expect(result['source'], 'noaa_ndbc');
    });

    test('rounds lat/lon to 0.1° precision', () {
      final result = stripPotentialPii({
        'lat': 42.3601,
        'lon': -70.5491,
      });

      expect(result['lat'], 42.4);
      expect(result['lon'], -70.5);
    });

    test('rounds latitude/longitude alias keys', () {
      final result = stripPotentialPii({
        'latitude': 41.9876,
        'longitude': -71.4123,
        'lng': -73.51,
      });

      expect(result['latitude'], 42.0);
      expect(result['longitude'], -71.4);
      expect(result['lng'], -73.5);
    });

    test('drops non-numeric values for coordinate keys', () {
      final result = stripPotentialPii({
        'lat': 'unknown',
        'lon': null,
      });

      expect(result.isEmpty, isTrue);
    });

    test('passes other keys through unchanged', () {
      final result = stripPotentialPii({
        'source': 'noaa_ndbc',
        'station_id': '44013',
        'attempt': 3,
        'error_kind': 'TimeoutException',
      });

      expect(result, {
        'source': 'noaa_ndbc',
        'station_id': '44013',
        'attempt': 3,
        'error_kind': 'TimeoutException',
      });
    });

    test('handles empty input', () {
      expect(stripPotentialPii({}), <String, dynamic>{});
    });

    test('preserves diagnostic context attached by adapters per TDD §11.4', () {
      // The TDD example attaches lat/lon + source as extras when capturing
      // a TimeoutException from an NOAA adapter. After stripping we should
      // still have the source tag and a coarsened location.
      final result = stripPotentialPii({
        'source': 'noaa_ndbc',
        'lat': 42.3601,
        'lon': -70.5491,
      });

      expect(result['source'], 'noaa_ndbc');
      expect(result['lat'], 42.4);
      expect(result['lon'], -70.5);
    });
  });
}

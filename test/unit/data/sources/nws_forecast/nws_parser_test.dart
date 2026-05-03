import 'dart:io';

import 'package:ai_marine_engine/data/sources/nws_forecast/nws_parser.dart';
import 'package:flutter_test/flutter_test.dart';

String _loadFixture(String name) =>
    File('test/fixtures/http_responses/$name').readAsStringSync();

void main() {
  group('parseForecastUrl', () {
    test('extracts forecastHourly from a real /points response', () {
      final body = _loadFixture('nws_points_42.36_-71.06.json');
      expect(
        parseForecastUrl(body),
        'https://api.weather.gov/gridpoints/BOX/71,101/forecast/hourly',
      );
    });

    test('falls back to forecast when forecastHourly is missing', () {
      const body = '{"properties":{'
          '"forecast":"https://api.weather.gov/gridpoints/BOX/72,90/forecast"'
          '}}';
      expect(
        parseForecastUrl(body),
        'https://api.weather.gov/gridpoints/BOX/72,90/forecast',
      );
    });

    test('throws FormatException when neither URL is present', () {
      const body = '{"properties":{"timeZone":"America/New_York"}}';
      expect(
        () => parseForecastUrl(body),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws FormatException when properties is missing', () {
      const body = '{"id":"foo"}';
      expect(
        () => parseForecastUrl(body),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('parseForecastPeriods', () {
    test('parses every period from the real Boston forecast fixture', () {
      final body = _loadFixture('nws_forecast_box_71_101.json');
      final periods = parseForecastPeriods(body);
      expect(periods, hasLength(4));
      expect(periods.first.windSpeedRaw, '10 mph');
      expect(periods.first.windDirectionRaw, 'NW');
      expect(periods.first.temperature, 52);
      expect(periods.first.startTime.isUtc, isTrue);
      // 11:00 EDT (UTC-4) = 15:00 UTC
      expect(periods.first.startTime, DateTime.utc(2026, 5, 3, 15));
    });

    test('throws FormatException on missing periods array', () {
      const body = '{"properties":{}}';
      expect(
        () => parseForecastPeriods(body),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws FormatException on a period missing required fields', () {
      const body = '{"properties":{"periods":[{"number":1}]}}';
      expect(
        () => parseForecastPeriods(body),
        throwsA(isA<FormatException>()),
      );
    });
  });
}

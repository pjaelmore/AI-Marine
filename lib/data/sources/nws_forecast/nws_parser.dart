import 'dart:convert';

import 'forecast_period.dart';

/// Extracts the forecast hourly URL from a `/points/{lat},{lon}` response
/// — TDD §5.4.1. Falls back to the (non-hourly) `forecast` URL when
/// `forecastHourly` is missing, which can happen on offshore points.
///
/// Throws [FormatException] when neither URL is present.
String parseForecastUrl(String pointsResponseBody) {
  final json = jsonDecode(pointsResponseBody) as Map<String, dynamic>;
  final props = json['properties'];
  if (props is! Map<String, dynamic>) {
    throw const FormatException(
      'NWS points response missing `properties` object',
    );
  }
  final hourly = props['forecastHourly'];
  if (hourly is String && hourly.isNotEmpty) return hourly;
  final standard = props['forecast'];
  if (standard is String && standard.isNotEmpty) return standard;
  throw const FormatException(
    'NWS points response missing both forecastHourly and forecast URLs',
  );
}

/// Parses a forecast (`/gridpoints/.../forecast` or `.../forecast/hourly`)
/// response into a list of [ForecastPeriod].
List<ForecastPeriod> parseForecastPeriods(String forecastResponseBody) {
  final json = jsonDecode(forecastResponseBody) as Map<String, dynamic>;
  final props = json['properties'];
  if (props is! Map<String, dynamic>) {
    throw const FormatException(
      'NWS forecast response missing `properties` object',
    );
  }
  final periods = props['periods'];
  if (periods is! List) {
    throw const FormatException(
      'NWS forecast response missing `periods` array',
    );
  }
  return periods.cast<Map<String, dynamic>>().map(_parsePeriod).toList();
}

ForecastPeriod _parsePeriod(Map<String, dynamic> p) {
  final start = p['startTime'] as String?;
  final end = p['endTime'] as String?;
  final temp = p['temperature'];
  if (start == null || end == null || temp == null) {
    throw FormatException('NWS forecast period missing required field: $p');
  }
  return ForecastPeriod(
    startTime: DateTime.parse(start).toUtc(),
    endTime: DateTime.parse(end).toUtc(),
    temperature: (temp as num).toDouble(),
    temperatureUnit: (p['temperatureUnit'] as String?) ?? 'F',
    windSpeedRaw: (p['windSpeed'] as String?) ?? '',
    windDirectionRaw: (p['windDirection'] as String?) ?? '',
    shortForecast: (p['shortForecast'] as String?) ?? '',
  );
}

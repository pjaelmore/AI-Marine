import 'dart:convert';

import 'tide_prediction.dart';

/// Parses NOAA Tides & Currents JSON predictions into [TidePrediction]
/// values — TDD §5.3.2.
///
/// Throws [FormatException] on malformed JSON, missing `predictions`
/// key, or rows that can't be parsed as `{t, v, type}`. The adapter
/// catches and converts to `SourceException`.
List<TidePrediction> parseTidePredictions(String body) {
  final json = jsonDecode(body) as Map<String, dynamic>;
  final raw = json['predictions'];
  if (raw is! List) {
    throw const FormatException(
      'tide-predictions response missing `predictions` array',
    );
  }
  return raw.cast<Map<String, dynamic>>().map(_parseRow).toList();
}

TidePrediction _parseRow(Map<String, dynamic> row) {
  final t = row['t'] as String?;
  final v = row['v'] as String?;
  final type = row['type'] as String?;
  if (t == null || v == null || type == null) {
    throw FormatException('tide-prediction row missing field: $row');
  }
  return TidePrediction(
    time: _parseNoaaUtcTimestamp(t),
    heightFt: double.parse(v),
    type: type == 'H' ? TideType.high : TideType.low,
  );
}

/// NOAA returns timestamps as `YYYY-MM-DD HH:MM` with no offset; we
/// request `time_zone=GMT` so they're UTC.
DateTime _parseNoaaUtcTimestamp(String s) {
  // Convert to ISO-8601 with explicit Z so DateTime.parse treats as UTC.
  return DateTime.parse('${s.replaceFirst(' ', 'T')}Z');
}

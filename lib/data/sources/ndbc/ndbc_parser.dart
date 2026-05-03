import 'buoy_observation.dart';

/// Parses the NDBC realtime2 text format into the latest observation —
/// TDD §5.2.3.
///
/// Format quick reference (column indexes match the captured fixture):
///   0–4   YY MM DD hh mn  (UTC timestamp)
///   5     WDIR  (degT, true)
///   6     WSPD  (m/s)
///   7     GST   (m/s)
///   8     WVHT  (m)
///   9     DPD   (sec)
///   12    PRES  (hPa)
///   13    ATMP  (degC)
///   14    WTMP  (degC)
///
/// Lines starting with `#` are headers; first non-header line is the
/// most recent observation. `MM` or empty cells parse to `null`.
///
/// Throws [FormatException] if the body has no observation rows or the
/// first row has too few columns to extract the timestamp; the adapter
/// catches and converts to [SourceException].
BuoyObservation parseLatestNdbc(String body, String stationId) {
  final lines = body.split('\n');
  final dataLines =
      lines.where((l) => l.isNotEmpty && !l.startsWith('#')).toList();
  if (dataLines.isEmpty) {
    throw const FormatException('NDBC response contained no observations');
  }
  final cols = dataLines.first.trim().split(RegExp(r'\s+'));
  if (cols.length < 5) {
    throw FormatException(
      'NDBC observation row had ${cols.length} columns; expected ≥ 5 '
      'for the timestamp prefix',
    );
  }
  return BuoyObservation(
    stationId: stationId,
    timestamp: _parseTimestamp(cols),
    windDirDegT: _maybeDouble(cols, 5),
    windSpeedMps: _maybeDouble(cols, 6),
    gustMps: _maybeDouble(cols, 7),
    waveHeightM: _maybeDouble(cols, 8),
    dominantPeriodSec: _maybeDouble(cols, 9),
    pressureHpa: _maybeDouble(cols, 12),
    airTempC: _maybeDouble(cols, 13),
    waterTempC: _maybeDouble(cols, 14),
  );
}

DateTime _parseTimestamp(List<String> cols) {
  final year = int.parse(cols[0]);
  final month = int.parse(cols[1]);
  final day = int.parse(cols[2]);
  final hour = int.parse(cols[3]);
  final minute = int.parse(cols[4]);
  return DateTime.utc(year, month, day, hour, minute);
}

double? _maybeDouble(List<String> cols, int index) {
  if (index >= cols.length) return null;
  final s = cols[index];
  if (s.isEmpty || s == 'MM') return null;
  return double.tryParse(s);
}

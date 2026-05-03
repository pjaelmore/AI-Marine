import '../../../core/types/conditions.dart';

/// Mile-per-hour to knot conversion factor. 1 mph = 0.86898 kt.
const double _mphToKnots = 0.86898;

/// Pre-built compass-abbreviation table — TDD §5.4.3.
const Map<String, double> _compassToDeg = {
  'N': 0,
  'NNE': 22.5,
  'NE': 45,
  'ENE': 67.5,
  'E': 90,
  'ESE': 112.5,
  'SE': 135,
  'SSE': 157.5,
  'S': 180,
  'SSW': 202.5,
  'SW': 225,
  'WSW': 247.5,
  'W': 270,
  'WNW': 292.5,
  'NW': 315,
  'NNW': 337.5,
};

/// Parses NWS wind data — TDD §5.4.3.
///
/// NWS reports wind speed as either a single value ("10 mph") or a range
/// ("10 to 14 kt") and direction as a compass abbreviation. We accept
/// both `mph` and `kt` units and normalise to knots.
///
/// Returns `null` when the speed string is "calm", empty, or unparseable
/// — a calm period is structurally a missing wind reading, and surfacing
/// `null` lets the engine suppress the wind modifier instead of treating
/// it as "0 kt from N" (which has spurious direction).
WindVector? parseNwsWind(String speedStr, String dirStr) {
  final s = speedStr.trim();
  if (s.isEmpty) return null;
  if (s.toLowerCase() == 'calm') return null;

  final match = RegExp(
    r'(\d+)(?:\s*to\s*(\d+))?\s*(mph|kt|km/h)?',
    caseSensitive: false,
  ).firstMatch(s);
  if (match == null) return null;

  final low = double.parse(match.group(1)!);
  final high = match.group(2) == null ? low : double.parse(match.group(2)!);
  final unit = (match.group(3) ?? 'mph').toLowerCase();

  double toKnots(double v) {
    switch (unit) {
      case 'kt':
        return v;
      case 'km/h':
        return v * 0.539957;
      case 'mph':
      default:
        return v * _mphToKnots;
    }
  }

  final speedKnots = toKnots((low + high) / 2);
  final gustsKnots = high > low ? toKnots(high) : null;

  // Direction may be empty (e.g., variable winds) — fall back to 0 = N.
  final dirDeg = _compassToDeg[dirStr.trim().toUpperCase()];

  return WindVector(
    speedKnots: speedKnots,
    directionDegrees: dirDeg ?? 0,
    gustsKnots: gustsKnots,
  );
}

/// Exposed for testing.
double compassAbbreviationToDegrees(String abbr) =>
    _compassToDeg[abbr.trim().toUpperCase()] ?? 0;

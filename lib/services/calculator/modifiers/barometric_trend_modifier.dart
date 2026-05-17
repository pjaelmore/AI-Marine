import '../../../core/types/conditions.dart';
import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

const double _barometricModifierMin = 0.0;
const double _barometricModifierMax = 2.0;

/// Multiplicative barometric-trend modifier (TDD §6).
///
/// Reads the pressure trend from [BarometricState] and looks up the
/// matching multiplier in [WeatherSensitivity]. The species data
/// carries the factor as a multiplier directly (1.0 neutral, >1
/// boost, <1 penalty), so unlike the curve-based modifiers this one
/// is a pure dispatch — no preference→multiplier conversion.
///
/// **Trend availability caveat:** the NDBC realtime2 feed doesn't
/// expose pressure tendency reliably, so the conditions service
/// currently hardcodes `BarometricTrend.stable` for every reading
/// (TDD §3.2 / Phase 3 adapter note). This modifier will return the
/// stable multiplier (1.0 by convention for most species) until
/// Phase 4+ derives a real trend from the cache history of
/// successive observations.
///
/// `frontalPassageFactor` and `cloudCoverPreference` are intentionally
/// not consumed here. Frontal passage needs windowed pressure
/// derivative + wind shift detection (a separate modifier once the
/// data lands); cloud cover comes from a different source path
/// entirely. Each gets its own slice.
ModifierApplication evaluateBarometricTrendModifier({
  required BarometricState barometric,
  required WeatherSensitivity sensitivity,
}) {
  final factor = switch (barometric.trend) {
    BarometricTrend.rising => sensitivity.risingPressureFactor,
    BarometricTrend.falling => sensitivity.fallingPressureFactor,
    // Stable is treated as fully neutral. Species data doesn't carry
    // a stableFactor field; the absence of pressure change shouldn't
    // help or hurt by itself.
    BarometricTrend.stable => 1.0,
  };
  // Clamp to the shared envelope so a poorly-tuned data file can't
  // hand back a 5× boost that violates the bar viz contract.
  final multiplier = factor.clamp(
    _barometricModifierMin,
    _barometricModifierMax,
  );

  return ModifierApplication(
    name: 'barometric_trend',
    value: multiplier,
    rangeMin: _barometricModifierMin,
    rangeMax: _barometricModifierMax,
    description: 'Pressure ${_trendLabel(barometric.trend)} '
        '(${barometric.pressureMillibars.toStringAsFixed(1)} hPa) — '
        'species ${_trendLabel(barometric.trend)}-pressure factor '
        '${multiplier.toStringAsFixed(2)}',
  );
}

String _trendLabel(BarometricTrend trend) {
  switch (trend) {
    case BarometricTrend.rising:
      return 'rising';
    case BarometricTrend.falling:
      return 'falling';
    case BarometricTrend.stable:
      return 'stable';
  }
}

import '../../../core/math/probability_curves.dart';
import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

/// Range envelope of [ModifierApplication.value] returned from
/// [evaluateWaterTempModifier]. Documented constants so the
/// recommendation-card bar viz reads the same values the modifier
/// computes against — they don't drift apart silently.
const double _waterTempModifierMin = 0.0;
const double _waterTempModifierMax = 2.0;

/// Multiplicative water-temperature modifier (TDD §6).
///
/// Maps the observed water temperature through a trapezoidal
/// preference curve framed by the species's two ranges:
///
///   - [ConditionProfile.toleratedTemp] sets the outer bounds: at or
///     beyond `tolerated.minF` / `tolerated.maxF` the multiplier is
///     0 (the fish can't survive there, and a passing migration gate
///     plus an out-of-tolerated reading is a data conflict that the
///     reasoning panel will flag).
///   - [ConditionProfile.optimalTemp] sets the [1.0]-preference
///     plateau between `optimal.minF` and `optimal.maxF`, so any
///     reading inside the optimal band returns the maximum multiplier.
///
/// Linear `multiplier = 2 × preference` puts the rangeMin/rangeMax at
/// 0/2 with neutral at 1.0 — boosts on the optimal end, dampens on
/// the tolerated edges.
///
/// `idealF` on each TemperatureRange is unused here; it's surfaced
/// for other consumers (e.g. a future temperature-gradient
/// contributor that wants the single peak).
ModifierApplication evaluateWaterTempModifier({
  required double waterTempF,
  required TemperatureRange optimalTemp,
  required TemperatureRange toleratedTemp,
}) {
  final preference = trapezoidAt(
    value: waterTempF,
    rangeMin: toleratedTemp.minF,
    idealLow: optimalTemp.minF,
    idealHigh: optimalTemp.maxF,
    rangeMax: toleratedTemp.maxF,
  );
  final multiplier = _waterTempModifierMin +
      preference * (_waterTempModifierMax - _waterTempModifierMin);

  final tempStr = waterTempF.toStringAsFixed(1);
  final optMinStr = optimalTemp.minF.toStringAsFixed(0);
  final optMaxStr = optimalTemp.maxF.toStringAsFixed(0);
  return ModifierApplication(
    name: 'water_temperature',
    value: multiplier,
    rangeMin: _waterTempModifierMin,
    rangeMax: _waterTempModifierMax,
    description: 'Water $tempStr°F vs optimal $optMinStr–$optMaxStr°F',
  );
}

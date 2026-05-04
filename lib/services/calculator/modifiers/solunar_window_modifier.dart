import '../../../core/types/conditions.dart';
import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

const double _solunarModifierMin = 0.0;
const double _solunarModifierMax = 2.0;

/// Multiplicative solunar-window modifier (TDD §6).
///
/// Closed-form composition of two enum dimensions:
///
///   `multiplier = 1.0 + sensitivityWeight × strengthWeight`
///
/// where sensitivityWeight is `{none: 0, low: 0.1, medium: 0.3, high: 0.6}`
/// and strengthWeight is `{minor: 0.5, major: 1.0}`. The matrix
/// produces:
///
/// | sens \ strength  | minor | major |
/// |------------------|-------|-------|
/// | none             | 1.00  | 1.00  |
/// | low              | 1.05  | 1.10  |
/// | medium           | 1.15  | 1.30  |
/// | high             | 1.30  | 1.60  |
///
/// No active window → 1.0 regardless of sensitivity. The modifier
/// only ever boosts (multiplier ≥ 1) — solunar inactivity isn't a
/// penalty in the same way wind or out-of-temp is, just an absence
/// of bonus.
///
/// Major takes precedence over minor when both are somehow active
/// (defensive — shouldn't happen with well-formed solunar data).
ModifierApplication evaluateSolunarWindowModifier({
  required SolunarState solunar,
  required SolunarSensitivity sensitivity,
  required DateTime time,
}) {
  final strengthWeight = _activeStrengthWeight(solunar, time);
  final sensitivityWeight = _sensitivityWeight(sensitivity);
  final multiplier = (1.0 + sensitivityWeight * strengthWeight).clamp(
    _solunarModifierMin,
    _solunarModifierMax,
  );

  return ModifierApplication(
    name: 'solunar_window',
    value: multiplier,
    rangeMin: _solunarModifierMin,
    rangeMax: _solunarModifierMax,
    description: _describe(solunar, sensitivity, time),
  );
}

double _activeStrengthWeight(SolunarState solunar, DateTime time) {
  if (solunar.majorWindow?.isActiveAt(time) ?? false) return 1.0;
  if (solunar.minorWindow?.isActiveAt(time) ?? false) return 0.5;
  return 0.0;
}

double _sensitivityWeight(SolunarSensitivity s) {
  switch (s) {
    case SolunarSensitivity.none:
      return 0.0;
    case SolunarSensitivity.low:
      return 0.1;
    case SolunarSensitivity.medium:
      return 0.3;
    case SolunarSensitivity.high:
      return 0.6;
  }
}

String _describe(
  SolunarState solunar,
  SolunarSensitivity sensitivity,
  DateTime time,
) {
  final majorActive = solunar.majorWindow?.isActiveAt(time) ?? false;
  final minorActive = solunar.minorWindow?.isActiveAt(time) ?? false;
  if (sensitivity == SolunarSensitivity.none) {
    return 'Solunar (species not sensitive)';
  }
  if (majorActive) return 'Solunar major window active';
  if (minorActive) return 'Solunar minor window active';
  return 'Solunar windows inactive';
}

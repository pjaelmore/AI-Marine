import '../../../core/types/conditions.dart';
import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

/// Same envelope as water-temp so the recommendation-card bar viz
/// reads uniformly across modifiers.
const double _tidePhaseModifierMin = 0.0;
const double _tidePhaseModifierMax = 2.0;

/// Multiplicative tide-phase modifier (TDD §6).
///
/// Looks up the current [TidePhase] in
/// [TidePreference.phaseWeights]; an absent phase reads as 0
/// (per the type's documented "absent keys default to 0" contract).
/// The weight in [0, 1] maps linearly to the modifier envelope so a
/// preference of 1.0 doubles the score and 0.0 nukes it.
///
/// `prefersSpringTides` is intentionally not consumed here. Spring
/// tides are a lunar-amplitude property not present in [TideState],
/// so the spring-tide bonus needs its own modifier with access to
/// the lunar phase. Lands in a later slice.
ModifierApplication evaluateTidePhaseModifier({
  required TidePhase phase,
  required TidePreference preference,
}) {
  final weight = preference.phaseWeights[phase] ?? 0.0;
  final multiplier = _tidePhaseModifierMin +
      weight * (_tidePhaseModifierMax - _tidePhaseModifierMin);
  return ModifierApplication(
    name: 'tide_phase',
    value: multiplier,
    rangeMin: _tidePhaseModifierMin,
    rangeMax: _tidePhaseModifierMax,
    description: 'Tide ${_phaseLabel(phase)} '
        '(species preference ${weight.toStringAsFixed(2)})',
  );
}

String _phaseLabel(TidePhase phase) {
  switch (phase) {
    case TidePhase.rising:
      return 'rising';
    case TidePhase.falling:
      return 'falling';
    case TidePhase.slackHigh:
      return 'slack high';
    case TidePhase.slackLow:
      return 'slack low';
  }
}

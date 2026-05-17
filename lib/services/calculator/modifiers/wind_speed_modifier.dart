import '../../../core/types/conditions.dart';
import '../../../core/types/score_result.dart';

const double _windSpeedModifierMin = 0.0;
const double _windSpeedModifierMax = 2.0;

/// Plateau upper bound (knots) — fishing is fine in any wind from
/// dead calm up through this speed.
const double _comfortablePlateauKt = 15.0;

/// Falloff endpoint (knots) — at and above this, the multiplier is 0.
/// 30 kt is small-craft-advisory territory; recreational fishing is
/// dangerous and unproductive past it.
const double _smallCraftAdvisoryKt = 30.0;

/// Multiplicative wind-speed modifier (TDD §6).
///
/// `ConditionProfile` doesn't carry a per-species wind preference —
/// high wind disrupts fishing regardless of species — so v1 uses a
/// fixed comfort curve. Future per-species sensitivity can land as a
/// new field on the profile without changing this function's
/// envelope.
///
/// Curve shape:
///   - 0 .. [_comfortablePlateauKt] kt → full preference (1.0).
///   - [_comfortablePlateauKt] .. [_smallCraftAdvisoryKt] kt →
///     linear falloff from 1.0 to 0.0.
///   - At and above [_smallCraftAdvisoryKt] → 0.
///
/// Same `[0, 2]` linear envelope (`multiplier = 2 × preference`) as
/// the other modifiers so the recommendation-card bar viz reads
/// uniformly.
///
/// The `trapezoidAt` helper isn't a clean fit because its
/// `value <= rangeMin` short-circuit returns 0 at the lower bound,
/// and a calm-water reading (0 kt) needs to score the maximum
/// preference. Inline math sidesteps the boundary-exclusivity.
ModifierApplication evaluateWindSpeedModifier({
  required WindVector wind,
}) {
  final speed = wind.speedKnots;
  final preference = _windPreference(speed);
  final multiplier = _windSpeedModifierMin +
      preference * (_windSpeedModifierMax - _windSpeedModifierMin);

  return ModifierApplication(
    name: 'wind_speed',
    value: multiplier,
    rangeMin: _windSpeedModifierMin,
    rangeMax: _windSpeedModifierMax,
    description: 'Wind ${speed.toStringAsFixed(1)} kt '
        '(comfortable ≤${_comfortablePlateauKt.toStringAsFixed(0)} kt, '
        'small-craft ${_smallCraftAdvisoryKt.toStringAsFixed(0)} kt)',
  );
}

double _windPreference(double speedKnots) {
  if (speedKnots <= _comfortablePlateauKt) return 1.0;
  if (speedKnots >= _smallCraftAdvisoryKt) return 0.0;
  return (_smallCraftAdvisoryKt - speedKnots) /
      (_smallCraftAdvisoryKt - _comfortablePlateauKt);
}

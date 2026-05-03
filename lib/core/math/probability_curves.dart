/// Trapezoidal preference curve — TDD §6.3.
///
/// Returns a value in `[0, 1]` indicating how strongly [value] sits inside
/// a species' tolerated range:
///
/// ```
///       1.0 ┤        ┌──────────┐
///           │       /            \
///       0.5 ┤      /              \
///           │     /                \
///       0.0 ┤────┘                  └────
///           rangeMin idealLow idealHigh rangeMax
/// ```
///
/// - 0.0 at or outside [rangeMin] / [rangeMax] (intolerable).
/// - Linear rise from 0 → 1 between [rangeMin] and [idealLow].
/// - 1.0 across the [idealLow]..[idealHigh] plateau.
/// - Linear fall from 1 → 0 between [idealHigh] and [rangeMax].
///
/// Inputs must satisfy `rangeMin <= idealLow <= idealHigh <= rangeMax`.
/// Degenerate cases (idealLow == rangeMin, idealHigh == rangeMax,
/// idealLow == idealHigh) all collapse correctly to half-triangles or
/// pure triangles.
double trapezoidAt({
  required double value,
  required double rangeMin,
  required double idealLow,
  required double idealHigh,
  required double rangeMax,
}) {
  assert(rangeMin <= idealLow, 'rangeMin must be <= idealLow');
  assert(idealLow <= idealHigh, 'idealLow must be <= idealHigh');
  assert(idealHigh <= rangeMax, 'idealHigh must be <= rangeMax');

  if (value <= rangeMin || value >= rangeMax) return 0.0;
  if (value >= idealLow && value <= idealHigh) return 1.0;

  if (value < idealLow) {
    final span = idealLow - rangeMin;
    if (span == 0) return 1.0; // degenerate: ideal sits on the rising edge
    return (value - rangeMin) / span;
  } else {
    final span = rangeMax - idealHigh;
    if (span == 0) return 1.0; // degenerate: ideal sits on the falling edge
    return (rangeMax - value) / span;
  }
}

/// Convenience for the triangle case where `idealLow == idealHigh`.
/// All the species-preference types in v1 (TemperatureRange,
/// DepthPreference, CurrentPreference) carry a single `idealX` field
/// and reduce to this shape.
double triangleAt({
  required double value,
  required double rangeMin,
  required double ideal,
  required double rangeMax,
}) =>
    trapezoidAt(
      value: value,
      rangeMin: rangeMin,
      idealLow: ideal,
      idealHigh: ideal,
      rangeMax: rangeMax,
    );

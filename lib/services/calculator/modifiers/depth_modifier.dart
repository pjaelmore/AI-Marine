import '../../../core/math/probability_curves.dart';
import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

const double _depthModifierMin = 0.0;
const double _depthModifierMax = 2.0;

/// Multiplicative point-depth modifier (TDD §6).
///
/// Uses [triangleAt] against [DepthPreference] — peaks at `idealFt`,
/// linear ramps down to 0 at `minFt` / `maxFt`. Same `[0, 2]`
/// envelope (`multiplier = 2 × preference`) as the other modifiers.
///
/// **Scope: this modifier covers point-depth-in-preferred-range only.**
/// In real fishing, "good depth" is composite — edge proximity (a
/// drop-off / ledge / channel edge where bait concentrates), depth
/// in the species's preferred range, water temp *at that depth* (not
/// the surface), and the other multipliers aligning at that spot.
/// We split those signals across modifiers and contributors:
///   - **Edge proximity** is the structure contributor's job, fed by
///     `StructureInfo.{dropOff, ledge, channelEdge}` types and
///     `distanceToContourTransitionM`. Don't double-count here.
///   - **Depth-stratified water temp** is a deliberate future data-
///     layer addition (NMEA 2000 transducer in Phase 7+, or a
///     modeled thermocline source). Surface temp comes through the
///     existing water-temp modifier.
///   - **Multiplier alignment** is the orchestrator's geometric
///     mean — this modifier just supplies one factor.
///
/// `getDepth` returns `unavailable` in v1 (depth needs ENC bathymetry
/// inference, Phase 7+), so this modifier will read neutral until
/// real depth data lands. Same "ready for when the data arrives"
/// pattern as the barometric and structure modifiers.
ModifierApplication evaluateDepthModifier({
  required double depthFt,
  required DepthPreference preference,
}) {
  final pref = triangleAt(
    value: depthFt,
    rangeMin: preference.minFt,
    ideal: preference.idealFt,
    rangeMax: preference.maxFt,
  );
  final multiplier =
      _depthModifierMin + pref * (_depthModifierMax - _depthModifierMin);

  return ModifierApplication(
    name: 'depth',
    value: multiplier,
    rangeMin: _depthModifierMin,
    rangeMax: _depthModifierMax,
    description: 'Depth ${depthFt.toStringAsFixed(1)} ft '
        'vs species ideal ${preference.idealFt.toStringAsFixed(0)} ft '
        '(range ${preference.minFt.toStringAsFixed(0)}'
        '–${preference.maxFt.toStringAsFixed(0)} ft)',
  );
}

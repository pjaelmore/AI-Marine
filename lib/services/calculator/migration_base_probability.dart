import '../../core/types/lat_lng.dart';
import '../../data/species/models/migration_model.dart';

/// Default base probability when the location is inside the species's
/// spatial range but no regional curve covers it. A data gap on a
/// specific point isn't an absence — the spatial-range polygon already
/// affirmed "this species can be here" — so we return a moderate
/// baseline rather than zero or one. 0.5 is the neutral midpoint:
/// modifiers and contributors can still push the final score either
/// way without the missing curve secretly anchoring the result.
const double _defaultPresenceWhenNoCurveCovers = 0.5;

/// Base probability seed for the calculator (TDD §6).
///
/// After the migration gate passes, the calculator multiplies modifiers
/// against this value and adds contributors on top. The seed encodes
/// "how present is the species at this place + week" before any
/// environmental conditions narrow the answer.
///
/// Semantics:
///   - Outside [MigrationModel.spatialRange] → 0. Defensive: the
///     gate should already have failed, but a caller skipping the
///     gate must still get a sane zero.
///   - Inside the spatial range, no regional curve covers the point →
///     [_defaultPresenceWhenNoCurveCovers] (0.5). Documented default;
///     callers wanting a stricter posture can override per-species
///     when species data lands.
///   - Inside one or more covering curves → the **maximum** presence
///     across them at this week-of-year. Same max-of-many policy as
///     the migration gate so a finer regional model can't be
///     undercut by a coarser overlapping one.
double calculateMigrationBaseProbability({
  required MigrationModel migration,
  required LatLng location,
  required DateTime time,
}) {
  if (!migration.spatialRange.contains(location)) return 0;

  final coveringCurves =
      migration.regionalCurves.where((c) => c.regionPolygon.contains(location));
  if (coveringCurves.isEmpty) return _defaultPresenceWhenNoCurveCovers;

  return coveringCurves
      .map((c) => c.presenceAt(time))
      .reduce((a, b) => a > b ? a : b);
}

import '../../core/types/lat_lng.dart';
import '../../core/types/score_result.dart';
import '../../data/species/models/migration_model.dart';

/// Hard gate: is the species actually present at [location] at [time]?
///
/// The recommendation engine refuses to score a location if this gate
/// fails — telling a user to fish for striped bass off Greenland in
/// January would shred trust faster than any other class of error.
///
/// Logic, in TDD §3.3.2 / §6 spirit:
///   - Outside the species's overall spatial range → fail.
///   - Inside spatial range, no regional curve covers this point →
///     pass. A data gap shouldn't synthesize an absence; the species
///     range polygon is authoritative for "could be here at all."
///   - Inside one or more regional curves: use the **maximum**
///     presence across covering curves at this week-of-year. Any
///     non-zero presence passes; zero everywhere fails. Max-of-many
///     means overlapping regional models can't accidentally
///     under-report (the curve with finer detail wins; the broader
///     curve never veto-fails the finer one).
///
/// The presence *magnitude* (0.0..1.0) is not consumed here — it
/// flows into the base probability (next slice) so a 0.1-presence
/// region scores lower than a 0.9-presence region without the gate
/// having to encode a threshold.
GateResult evaluateMigrationGate({
  required MigrationModel migration,
  required LatLng location,
  required DateTime time,
}) {
  if (!migration.spatialRange.contains(location)) {
    return const GateResult(
      name: 'migration_presence',
      passed: false,
      failureReason: 'location is outside the species spatial range',
    );
  }

  final coveringCurves = migration.regionalCurves
      .where((c) => c.regionPolygon.contains(location))
      .toList(growable: false);
  if (coveringCurves.isEmpty) {
    return const GateResult(name: 'migration_presence', passed: true);
  }

  final maxPresence = coveringCurves
      .map((c) => c.presenceAt(time))
      .reduce((a, b) => a > b ? a : b);
  if (maxPresence > 0) {
    return const GateResult(name: 'migration_presence', passed: true);
  }
  // Identify the closest-matching region for the failure reason; a
  // user-facing reason naming the region beats a bare "no presence".
  final region = coveringCurves.first;
  return GateResult(
    name: 'migration_presence',
    passed: false,
    failureReason:
        'no presence for region ${region.regionId} this week of year',
  );
}

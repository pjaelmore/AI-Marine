import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/types/lat_lng.dart';
import '../core/types/score_result.dart';
import '../data/species/models/species_record.dart';
import '../data/species/species_database.dart';
import '../services/calculator/probability_calculator.dart';
import 'component_providers.dart';

/// Family-key shape for [scoreAtLocationProvider]. Uses a Dart record so
/// equality is structural — Riverpod's family cache compares queries by
/// value, so two reads with the same `(speciesId, location, time)`
/// resolve to the same cached future.
typedef ScoreQuery = ({
  String speciesId,
  LatLng location,
  DateTime time,
});

/// Family-key shape for [scoreGridProvider].
typedef GridQuery = ({
  String speciesId,
  LatLngBounds bbox,
  DateTime time,
  double resolutionNm,
});

/// Loads the species manifest + every species file into memory at app
/// startup. Returns the [SpeciesDatabase] only after the manifest has
/// loaded so callers can `ref.watch(...).when(...)` to render a startup
/// splash while species data resolves.
final speciesDatabaseProvider = FutureProvider<SpeciesDatabase>((ref) async {
  final db = SpeciesDatabase.create();
  await db.loadAll();
  return db;
});

/// All loaded species records, sorted by id. Surfaces in the species
/// picker UI; widgets watch this rather than [speciesDatabaseProvider]
/// when they need the list rather than the loader.
final availableSpeciesProvider = FutureProvider<List<SpeciesRecord>>((
  ref,
) async {
  final db = await ref.watch(speciesDatabaseProvider.future);
  final records = await Future.wait(db.availableSpeciesIds.map(db.load));
  return records..sort((a, b) => a.id.compareTo(b.id));
});

/// User's current target species. Defaults to common snook — most-targeted
/// FL inshore species and the species the calibration tuple is pinned
/// against, so we know it produces sensible scores out of the gate.
/// Override at app startup once the species picker has a value.
final selectedSpeciesIdProvider =
    StateProvider<String>((ref) => 'common-snook');

/// User's lookup time. Defaults to "now" (UTC); the trip planner UI
/// overrides this when the user picks a future date/time. Held as a
/// regular [DateTime] (not a stream) so the same time is used for all
/// scoring calls within a single render — heatmap cells are scored at
/// the same instant.
final selectedTimeProvider = StateProvider<DateTime>(
  (ref) => DateTime.now().toUtc(),
);

/// The probability calculator, composing the cache-backed
/// [ConditionsService]. Async because the conditions service waits on
/// the bundled station-list assets.
final probabilityCalculatorProvider =
    FutureProvider<ProbabilityCalculator>((ref) async {
  final conditions = await ref.watch(conditionsServiceProvider.future);
  return ProbabilityCalculator(conditions: conditions);
});

/// Score for a single (species, location, time). Auto-disposes so a
/// flock of dismissed recommendation cards doesn't leak futures.
///
/// Watching this from a widget gives a [AsyncValue<ScoreResult>] that
/// the recommendation card can `.when(loading:, error:, data:)` against.
/// Two calls with the same query (record-equality) share the same
/// underlying future — useful for the heatmap re-using a cell's score
/// when the user taps it open.
final scoreAtLocationProvider =
    FutureProvider.autoDispose.family<ScoreResult, ScoreQuery>((
  ref,
  query,
) async {
  final calc = await ref.watch(probabilityCalculatorProvider.future);
  final db = await ref.watch(speciesDatabaseProvider.future);
  final species = await db.load(query.speciesId);
  return calc.scoreLocation(
    species: species,
    location: query.location,
    time: query.time,
  );
});

/// Score grid for the heatmap layer. Auto-disposes when the user pans
/// off the bbox so old grids don't pile up; the cache absorbs duplicate
/// condition fetches across cells when the new bbox overlaps.
final scoreGridProvider =
    FutureProvider.autoDispose.family<List<ScoreResult>, GridQuery>((
  ref,
  query,
) async {
  final calc = await ref.watch(probabilityCalculatorProvider.future);
  final db = await ref.watch(speciesDatabaseProvider.future);
  final species = await db.load(query.speciesId);
  return calc.scoreGrid(
    species: species,
    bbox: query.bbox,
    time: query.time,
    resolutionNm: query.resolutionNm,
  );
});

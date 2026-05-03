import 'package:drift/drift.dart';

/// Computed scores keyed by species + cell + conditions-hash — TDD §4.1.4.
/// Identical conditions hash to the same key (TDD §6.6) so the cache
/// hits across pans/zooms when conditions haven't materially changed.
@DataClassName('ScoreCacheRow')
class ScoreCache extends Table {
  TextColumn get cacheKey => text()();
  TextColumn get speciesId => text()();
  RealColumn get cellLat => real()();
  RealColumn get cellLon => real()();
  TextColumn get conditionsHash => text()();
  RealColumn get score => real()();
  TextColumn get reasoningJson => text()();
  IntColumn get computedAtUtc => integer()();
  IntColumn get validUntilUtc => integer()();
  IntColumn get lastAccessedUtc => integer()();

  @override
  Set<Column<Object>> get primaryKey => {cacheKey};
}

import 'package:drift/drift.dart';

/// Tide predictions keyed by station + day bucket — TDD §4.1.4. Cold
/// layer by default since tide predictions are expensive to fetch and
/// stable for long horizons; the `pinned` flag lets pre-trip downloads
/// keep specific stations through eviction passes.
@DataClassName('TideCacheRow')
class TideCache extends Table {
  TextColumn get cacheKey => text()();
  TextColumn get stationId => text()();
  TextColumn get dayBucket => text()();
  TextColumn get predictionsJson => text()();
  IntColumn get fetchedAtUtc => integer()();
  IntColumn get validUntilUtc => integer()();
  IntColumn get sizeBytes => integer()();
  IntColumn get lastAccessedUtc => integer()();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {cacheKey};
}

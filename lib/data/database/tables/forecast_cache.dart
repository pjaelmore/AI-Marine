import 'package:drift/drift.dart';

/// Marine forecast keyed by zone + day bucket — TDD §4.1.4. Pinable for
/// pre-trip cold-cache downloads.
@DataClassName('ForecastCacheRow')
class ForecastCache extends Table {
  TextColumn get cacheKey => text()();
  TextColumn get zoneId => text()();
  TextColumn get dayBucket => text()();
  TextColumn get forecastJson => text()();
  IntColumn get fetchedAtUtc => integer()();
  IntColumn get validUntilUtc => integer()();
  IntColumn get sizeBytes => integer()();
  IntColumn get lastAccessedUtc => integer()();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {cacheKey};
}

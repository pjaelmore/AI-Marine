import 'package:drift/drift.dart';

/// Warm cache for API-derived condition values, keyed by source/time —
/// TDD §4.1.4. The DDL includes two indexes (idx_conditions_valid for
/// freshness queries, idx_conditions_lru for eviction by last access);
/// they're issued from AppDatabase.onCreate via customStatement.
@DataClassName('ConditionsCacheRow')
class ConditionsCache extends Table {
  TextColumn get cacheKey => text()();
  TextColumn get dataType => text()();
  TextColumn get source => text()();
  TextColumn get valueJson => text()();
  IntColumn get fetchedAtUtc => integer()();
  IntColumn get validUntilUtc => integer()();
  IntColumn get sizeBytes => integer()();
  IntColumn get lastAccessedUtc => integer()();

  @override
  Set<Column<Object>> get primaryKey => {cacheKey};
}

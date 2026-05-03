import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/conditions_cache.dart';

part 'conditions_cache_dao.g.dart';

/// CRUD over the conditions_cache warm-layer table. The cache manager
/// (Phase 4) will own freshness and eviction; v1 surfaces just enough
/// for that work to land on top.
@DriftAccessor(tables: [ConditionsCache])
class ConditionsCacheDao extends DatabaseAccessor<AppDatabase>
    with _$ConditionsCacheDaoMixin {
  ConditionsCacheDao(super.db);

  Future<void> upsert(ConditionsCacheCompanion entry) =>
      into(conditionsCache).insertOnConflictUpdate(entry);

  Future<ConditionsCacheRow?> getByKey(String cacheKey) =>
      (select(conditionsCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .getSingleOrNull();

  /// Marks a cache hit by stamping last_accessed_utc. Called every time
  /// the manager serves a value from this layer.
  Future<int> touchLastAccessed(String cacheKey, int nowUtcMs) =>
      (update(conditionsCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(ConditionsCacheCompanion(lastAccessedUtc: Value(nowUtcMs)));

  Future<int> deleteByKey(String cacheKey) =>
      (delete(conditionsCache)..where((t) => t.cacheKey.equals(cacheKey))).go();

  /// Total bytes consumed by this cache; the manager budgets against
  /// this and the other caches' sums.
  Future<int> sumSizeBytes() async {
    final query = selectOnly(conditionsCache)
      ..addColumns([conditionsCache.sizeBytes.sum()]);
    final row = await query.getSingleOrNull();
    return row?.read(conditionsCache.sizeBytes.sum()) ?? 0;
  }

  /// Drops every row whose `valid_until_utc <= [nowUtcMs]`. Returns
  /// the number of rows removed. Called by the EvictionService on
  /// scheduled sweeps so stale entries don't accumulate between
  /// accesses (the warm-cache get-path drops stale rows inline only
  /// when they're actually queried).
  Future<int> deleteExpired(int nowUtcMs) => (delete(conditionsCache)
        ..where((t) => t.validUntilUtc.isSmallerOrEqualValue(nowUtcMs)))
      .go();
}

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/forecast_cache.dart';

part 'forecast_cache_dao.g.dart';

/// CRUD over the forecast_cache table. Pinable for pre-trip downloads.
@DriftAccessor(tables: [ForecastCache])
class ForecastCacheDao extends DatabaseAccessor<AppDatabase>
    with _$ForecastCacheDaoMixin {
  ForecastCacheDao(super.db);

  Future<void> upsert(ForecastCacheCompanion entry) =>
      into(forecastCache).insertOnConflictUpdate(entry);

  Future<ForecastCacheRow?> getByKey(String cacheKey) =>
      (select(forecastCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .getSingleOrNull();

  Future<int> touchLastAccessed(String cacheKey, int nowUtcMs) =>
      (update(forecastCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(ForecastCacheCompanion(lastAccessedUtc: Value(nowUtcMs)));

  Future<int> deleteByKey(String cacheKey) =>
      (delete(forecastCache)..where((t) => t.cacheKey.equals(cacheKey))).go();

  Future<int> setPinned(String cacheKey, {required bool pinned}) =>
      (update(forecastCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(ForecastCacheCompanion(pinned: Value(pinned)));

  /// Evicts the oldest [limit] unpinned entries by last-access time.
  Future<int> evictUnpinned({required int limit}) async {
    final victims = await (select(forecastCache)
          ..where((t) => t.pinned.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.lastAccessedUtc)])
          ..limit(limit))
        .get();
    if (victims.isEmpty) return 0;
    final keys = victims.map((r) => r.cacheKey).toList();
    return (delete(forecastCache)..where((t) => t.cacheKey.isIn(keys))).go();
  }

  /// Drops every unpinned row whose `valid_until_utc <= [nowUtcMs]`.
  /// Pinned rows survive even when stale (offline trip use case).
  Future<int> deleteExpiredUnpinned(int nowUtcMs) => (delete(forecastCache)
        ..where(
          (t) =>
              t.pinned.equals(false) &
              t.validUntilUtc.isSmallerOrEqualValue(nowUtcMs),
        ))
      .go();
}

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/tide_cache.dart';

part 'tide_cache_dao.g.dart';

/// CRUD over the tide_cache table. Pinable for pre-trip downloads.
@DriftAccessor(tables: [TideCache])
class TideCacheDao extends DatabaseAccessor<AppDatabase>
    with _$TideCacheDaoMixin {
  TideCacheDao(super.db);

  Future<void> upsert(TideCacheCompanion entry) =>
      into(tideCache).insertOnConflictUpdate(entry);

  Future<TideCacheRow?> getByKey(String cacheKey) =>
      (select(tideCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .getSingleOrNull();

  Future<int> touchLastAccessed(String cacheKey, int nowUtcMs) =>
      (update(tideCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(TideCacheCompanion(lastAccessedUtc: Value(nowUtcMs)));

  Future<int> deleteByKey(String cacheKey) =>
      (delete(tideCache)..where((t) => t.cacheKey.equals(cacheKey))).go();

  Future<int> setPinned(String cacheKey, {required bool pinned}) =>
      (update(tideCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(TideCacheCompanion(pinned: Value(pinned)));

  Future<int> evictUnpinned({required int limit}) async {
    final victims = await (select(tideCache)
          ..where((t) => t.pinned.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.lastAccessedUtc)])
          ..limit(limit))
        .get();
    if (victims.isEmpty) return 0;
    final keys = victims.map((r) => r.cacheKey).toList();
    return (delete(tideCache)..where((t) => t.cacheKey.isIn(keys))).go();
  }
}

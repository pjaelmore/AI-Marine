import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/score_cache.dart';

part 'score_cache_dao.g.dart';

/// CRUD over the score_cache warm-layer table.
@DriftAccessor(tables: [ScoreCache])
class ScoreCacheDao extends DatabaseAccessor<AppDatabase>
    with _$ScoreCacheDaoMixin {
  ScoreCacheDao(super.db);

  Future<void> upsert(ScoreCacheCompanion entry) =>
      into(scoreCache).insertOnConflictUpdate(entry);

  Future<ScoreCacheRow?> getByKey(String cacheKey) =>
      (select(scoreCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .getSingleOrNull();

  Future<int> touchLastAccessed(String cacheKey, int nowUtcMs) =>
      (update(scoreCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(ScoreCacheCompanion(lastAccessedUtc: Value(nowUtcMs)));

  Future<int> deleteByKey(String cacheKey) =>
      (delete(scoreCache)..where((t) => t.cacheKey.equals(cacheKey))).go();

  /// Drops every row whose validUntilUtc has passed [nowUtcMs] —
  /// freshness eviction the cache manager calls on a schedule.
  Future<int> deleteExpired(int nowUtcMs) => (delete(scoreCache)
        ..where((t) => t.validUntilUtc.isSmallerThanValue(nowUtcMs)))
      .go();
}

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/chart_tile_cache.dart';

part 'chart_tile_cache_dao.g.dart';

/// CRUD over the chart_tile_cache table. Crosses warm and cold layers
/// via the `pinned` flag (TDD §4.1.4); eviction (TDD §4.1.6) operates
/// strictly on `pinned = false` rows.
@DriftAccessor(tables: [ChartTileCache])
class ChartTileCacheDao extends DatabaseAccessor<AppDatabase>
    with _$ChartTileCacheDaoMixin {
  ChartTileCacheDao(super.db);

  Future<void> upsert(ChartTileCacheCompanion entry) =>
      into(chartTileCache).insertOnConflictUpdate(entry);

  Future<ChartTileCacheRow?> getByKey(String cacheKey) =>
      (select(chartTileCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .getSingleOrNull();

  Future<int> touchLastAccessed(String cacheKey, int nowUtcMs) =>
      (update(chartTileCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(ChartTileCacheCompanion(lastAccessedUtc: Value(nowUtcMs)));

  Future<int> deleteByKey(String cacheKey) =>
      (delete(chartTileCache)..where((t) => t.cacheKey.equals(cacheKey))).go();

  /// Pin or unpin a tile — pre-trip cache downloads pin; user-initiated
  /// purges in Settings (TDD §10.6) clear pins.
  Future<int> setPinned(String cacheKey, {required bool pinned}) =>
      (update(chartTileCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .write(ChartTileCacheCompanion(pinned: Value(pinned)));

  /// Evicts the oldest [limit] unpinned tiles by last-access time.
  /// Mirrors the §4.1.6 SQL pattern.
  Future<int> evictUnpinned({required int limit}) async {
    final victims = await (select(chartTileCache)
          ..where((t) => t.pinned.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.lastAccessedUtc)])
          ..limit(limit))
        .get();
    if (victims.isEmpty) return 0;
    final keys = victims.map((r) => r.cacheKey).toList();
    return (delete(chartTileCache)..where((t) => t.cacheKey.isIn(keys))).go();
  }

  Future<int> sumSizeBytes() async {
    final query = selectOnly(chartTileCache)
      ..addColumns([chartTileCache.sizeBytes.sum()]);
    final row = await query.getSingleOrNull();
    return row?.read(chartTileCache.sizeBytes.sum()) ?? 0;
  }
}

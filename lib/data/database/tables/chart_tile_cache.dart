import 'package:drift/drift.dart';

/// ENC tile blobs keyed by z/x/y/revision — TDD §4.1.4.
///
/// Crosses warm and cold layers: passive tiles are warm (LRU-evictable),
/// pre-trip pinned tiles are cold and survive eviction. The cache manager
/// layer (Phase 4) reads `pinned` when sweeping; eviction SQL is in
/// §4.1.6 and lands with that work.
@DataClassName('ChartTileCacheRow')
class ChartTileCache extends Table {
  TextColumn get cacheKey => text()();
  IntColumn get zoom => integer()();
  IntColumn get x => integer()();
  IntColumn get y => integer()();
  TextColumn get chartRevision => text()();
  BlobColumn get tileBlob => blob()();
  IntColumn get sizeBytes => integer()();
  IntColumn get fetchedAtUtc => integer()();
  IntColumn get lastAccessedUtc => integer()();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {cacheKey};
}

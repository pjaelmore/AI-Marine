import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

ChartTileCacheCompanion _tile(
  String key, {
  int lastAccessed = 1000,
  bool pinned = false,
}) =>
    ChartTileCacheCompanion(
      cacheKey: Value(key),
      zoom: const Value(11),
      x: const Value(622),
      y: const Value(757),
      chartRevision: const Value('2026.04'),
      tileBlob: Value(Uint8List.fromList([1, 2, 3, 4])),
      sizeBytes: const Value(4),
      fetchedAtUtc: const Value(1000),
      lastAccessedUtc: Value(lastAccessed),
      pinned: Value(pinned),
    );

void main() {
  final skipReason = setupSqlite3();
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test(
    'BLOB round-trip preserves bytes',
    () async {
      await db.chartTileCacheDao.upsert(_tile('z11_x622_y757'));
      final row = await db.chartTileCacheDao.getByKey('z11_x622_y757');
      expect(row?.tileBlob, equals(Uint8List.fromList([1, 2, 3, 4])));
    },
    skip: skipReason,
  );

  test(
    'setPinned flips the pinned flag',
    () async {
      await db.chartTileCacheDao.upsert(_tile('k1'));
      expect((await db.chartTileCacheDao.getByKey('k1'))!.pinned, isFalse);
      await db.chartTileCacheDao.setPinned('k1', pinned: true);
      expect((await db.chartTileCacheDao.getByKey('k1'))!.pinned, isTrue);
    },
    skip: skipReason,
  );

  test(
    'evictUnpinned removes oldest unpinned by last-access; pinned survive',
    () async {
      // Three rows: oldest is pinned (immune), middle and newest are not.
      await db.chartTileCacheDao
          .upsert(_tile('pinned_oldest', lastAccessed: 100, pinned: true));
      await db.chartTileCacheDao
          .upsert(_tile('warm_middle', lastAccessed: 500));
      await db.chartTileCacheDao
          .upsert(_tile('warm_newest', lastAccessed: 1000));

      final removed = await db.chartTileCacheDao.evictUnpinned(limit: 1);
      expect(removed, 1);

      // Middle (oldest unpinned) is gone; pinned and newest survive.
      expect(await db.chartTileCacheDao.getByKey('pinned_oldest'), isNotNull);
      expect(await db.chartTileCacheDao.getByKey('warm_middle'), isNull);
      expect(await db.chartTileCacheDao.getByKey('warm_newest'), isNotNull);
    },
    skip: skipReason,
  );

  test(
    'sumSizeBytes counts every row regardless of pinned state',
    () async {
      await db.chartTileCacheDao.upsert(_tile('a'));
      await db.chartTileCacheDao.upsert(_tile('b', pinned: true));
      expect(await db.chartTileCacheDao.sumSizeBytes(), 8);
    },
    skip: skipReason,
  );
}

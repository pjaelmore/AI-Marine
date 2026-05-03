import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

TideCacheCompanion _entry(
  String key, {
  int lastAccessed = 1000,
  bool pinned = false,
}) =>
    TideCacheCompanion(
      cacheKey: Value(key),
      stationId: const Value('8443970'),
      dayBucket: const Value('2026-05-22'),
      predictionsJson: const Value('{}'),
      fetchedAtUtc: const Value(1000),
      validUntilUtc: const Value(9999),
      sizeBytes: const Value(50),
      lastAccessedUtc: Value(lastAccessed),
      pinned: Value(pinned),
    );

void main() {
  final skipReason = setupSqlite3();
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test(
    'upsert + getByKey round-trips a tide-prediction entry',
    () async {
      await db.tideCacheDao.upsert(_entry('k1'));
      final row = await db.tideCacheDao.getByKey('k1');
      expect(row?.stationId, '8443970');
    },
    skip: skipReason,
  );

  test(
    'setPinned + evictUnpinned: pinned rows survive eviction',
    () async {
      await db.tideCacheDao
          .upsert(_entry('boston', lastAccessed: 100, pinned: true));
      await db.tideCacheDao.upsert(_entry('newport', lastAccessed: 500));
      final removed = await db.tideCacheDao.evictUnpinned(limit: 5);
      expect(removed, 1);
      expect(await db.tideCacheDao.getByKey('boston'), isNotNull);
      expect(await db.tideCacheDao.getByKey('newport'), isNull);
    },
    skip: skipReason,
  );
}

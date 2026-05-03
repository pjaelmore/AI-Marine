import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

ForecastCacheCompanion _entry(
  String key, {
  int lastAccessed = 1000,
  bool pinned = false,
}) =>
    ForecastCacheCompanion(
      cacheKey: Value(key),
      zoneId: const Value('ANZ250'),
      dayBucket: const Value('2026-05-22'),
      forecastJson: const Value('{}'),
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
    'upsert + getByKey round-trips a forecast entry',
    () async {
      await db.forecastCacheDao.upsert(_entry('k1'));
      final row = await db.forecastCacheDao.getByKey('k1');
      expect(row?.zoneId, 'ANZ250');
      expect(row?.dayBucket, '2026-05-22');
    },
    skip: skipReason,
  );

  test(
    'evictUnpinned spares pinned rows even when older',
    () async {
      await db.forecastCacheDao
          .upsert(_entry('pinned', lastAccessed: 100, pinned: true));
      await db.forecastCacheDao.upsert(_entry('warm', lastAccessed: 500));
      final removed = await db.forecastCacheDao.evictUnpinned(limit: 5);
      expect(removed, 1);
      expect(await db.forecastCacheDao.getByKey('pinned'), isNotNull);
      expect(await db.forecastCacheDao.getByKey('warm'), isNull);
    },
    skip: skipReason,
  );
}

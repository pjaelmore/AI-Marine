import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

ConditionsCacheCompanion _entry(String key, {int sizeBytes = 100}) =>
    ConditionsCacheCompanion(
      cacheKey: Value(key),
      dataType: const Value('water_temp'),
      source: const Value('noaa_ndbc'),
      valueJson: const Value('{"value":62.0,"unit":"F"}'),
      fetchedAtUtc: const Value(1000),
      validUntilUtc: const Value(2000),
      sizeBytes: Value(sizeBytes),
      lastAccessedUtc: const Value(1000),
    );

void main() {
  final skipReason = setupSqlite3();
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test(
    'upsert + getByKey round-trips and replaces on duplicate key',
    () async {
      await db.conditionsCacheDao.upsert(_entry('k1'));
      var row = await db.conditionsCacheDao.getByKey('k1');
      expect(row?.dataType, 'water_temp');

      await db.conditionsCacheDao.upsert(_entry('k1', sizeBytes: 200));
      row = await db.conditionsCacheDao.getByKey('k1');
      expect(row?.sizeBytes, 200);
    },
    skip: skipReason,
  );

  test(
    'touchLastAccessed updates only the access timestamp',
    () async {
      await db.conditionsCacheDao.upsert(_entry('k1'));
      await db.conditionsCacheDao.touchLastAccessed('k1', 9999);
      final row = await db.conditionsCacheDao.getByKey('k1');
      expect(row?.lastAccessedUtc, 9999);
      expect(row?.fetchedAtUtc, 1000, reason: 'fetched stamp untouched');
    },
    skip: skipReason,
  );

  test(
    'sumSizeBytes returns 0 on empty and the sum across rows otherwise',
    () async {
      expect(await db.conditionsCacheDao.sumSizeBytes(), 0);
      await db.conditionsCacheDao.upsert(_entry('a', sizeBytes: 100));
      await db.conditionsCacheDao.upsert(_entry('b', sizeBytes: 250));
      expect(await db.conditionsCacheDao.sumSizeBytes(), 350);
    },
    skip: skipReason,
  );
}

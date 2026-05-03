import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

ScoreCacheCompanion _entry(
  String key, {
  required int validUntil,
  double score = 7.5,
}) =>
    ScoreCacheCompanion(
      cacheKey: Value(key),
      speciesId: const Value('striped_bass'),
      cellLat: const Value(42.36),
      cellLon: const Value(-70.55),
      conditionsHash: const Value('abc123'),
      score: Value(score),
      reasoningJson: const Value('{}'),
      computedAtUtc: const Value(1000),
      validUntilUtc: Value(validUntil),
      lastAccessedUtc: const Value(1000),
    );

void main() {
  final skipReason = setupSqlite3();
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test(
    'upsert + getByKey round-trips a score',
    () async {
      await db.scoreCacheDao.upsert(_entry('k1', validUntil: 5000));
      final row = await db.scoreCacheDao.getByKey('k1');
      expect(row?.score, 7.5);
      expect(row?.speciesId, 'striped_bass');
    },
    skip: skipReason,
  );

  test(
    'deleteExpired removes only rows whose validUntilUtc has passed now',
    () async {
      await db.scoreCacheDao.upsert(_entry('expired', validUntil: 1000));
      await db.scoreCacheDao.upsert(_entry('alive', validUntil: 9999));
      final removed = await db.scoreCacheDao.deleteExpired(5000);
      expect(removed, 1);
      expect(await db.scoreCacheDao.getByKey('expired'), isNull);
      expect(await db.scoreCacheDao.getByKey('alive'), isNotNull);
    },
    skip: skipReason,
  );
}

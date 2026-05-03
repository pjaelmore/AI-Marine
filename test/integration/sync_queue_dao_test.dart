import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

SyncQueueCompanion _entry({
  required String table,
  required String recordId,
  required int enqueuedAtMs,
}) =>
    SyncQueueCompanion(
      targetTable: Value(table),
      recordId: Value(recordId),
      operation: const Value('insert'),
      payloadJson: const Value('{}'),
      enqueuedAtUtc: Value(enqueuedAtMs),
    );

void main() {
  final skipReason = setupSqlite3();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'pending() is empty on a fresh database',
    () async {
      expect(await db.syncQueueDao.pending(), isEmpty);
    },
    skip: skipReason,
  );

  test(
    'enqueue + pending returns entries oldest-first',
    () async {
      await db.syncQueueDao.enqueue(
        _entry(table: 'catches', recordId: 'a', enqueuedAtMs: 1000),
      );
      await db.syncQueueDao.enqueue(
        _entry(table: 'catches', recordId: 'b', enqueuedAtMs: 2000),
      );
      final pending = await db.syncQueueDao.pending();
      expect(pending.map((e) => e.recordId), ['a', 'b']);
    },
    skip: skipReason,
  );

  test(
    'dequeue removes the entry by id',
    () async {
      final firstId = await db.syncQueueDao.enqueue(
        _entry(table: 'catches', recordId: 'a', enqueuedAtMs: 1000),
      );
      await db.syncQueueDao.enqueue(
        _entry(table: 'catches', recordId: 'b', enqueuedAtMs: 2000),
      );
      final removed = await db.syncQueueDao.dequeue(firstId);
      expect(removed, 1);
      final pending = await db.syncQueueDao.pending();
      expect(pending.map((e) => e.recordId), ['b']);
    },
    skip: skipReason,
  );
}

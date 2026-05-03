import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

TripPlansCompanion _plan(String id, {required int startMs}) =>
    TripPlansCompanion(
      id: Value(id),
      name: Value('Trip $id'),
      boundsSwLat: const Value(42.0),
      boundsSwLon: const Value(-71.0),
      boundsNeLat: const Value(43.0),
      boundsNeLon: const Value(-70.0),
      plannedStartUtc: Value(startMs),
      plannedEndUtc: Value(startMs + Duration.millisecondsPerHour * 6),
      targetSpeciesId: const Value('striped_bass'),
      cacheStatusJson: const Value('{"tiles":0,"forecasts":0}'),
      createdAtUtc: Value(startMs),
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
    'upsert + getById round-trips a trip plan',
    () async {
      final plan = _plan('trip-001', startMs: 1700000000000);
      await db.tripPlansDao.upsert(plan);
      final restored = await db.tripPlansDao.getById('trip-001');
      expect(restored, isNotNull);
      expect(restored!.id, 'trip-001');
      expect(restored.targetSpeciesId, 'striped_bass');
      expect(restored.boundsSwLat, 42.0);
    },
    skip: skipReason,
  );

  test(
    'getAll returns plans ordered by plannedStartUtc descending',
    () async {
      await db.tripPlansDao.upsert(_plan('older', startMs: 1000000000000));
      await db.tripPlansDao.upsert(_plan('newer', startMs: 1700000000000));
      final all = await db.tripPlansDao.getAll();
      expect(all.map((p) => p.id), ['newer', 'older']);
    },
    skip: skipReason,
  );

  test(
    'deleteById removes only the targeted plan',
    () async {
      await db.tripPlansDao.upsert(_plan('a', startMs: 1700000000000));
      await db.tripPlansDao.upsert(_plan('b', startMs: 1700000000000));
      final removed = await db.tripPlansDao.deleteById('a');
      expect(removed, 1);
      final all = await db.tripPlansDao.getAll();
      expect(all.map((p) => p.id), ['b']);
    },
    skip: skipReason,
  );
}

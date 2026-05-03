import 'package:ai_marine_engine/core/types/catch_record.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

CatchRecord _decoratedCatch({required String id, required DateTime ts}) =>
    CatchRecord(
      id: id,
      userId: 'user-paul',
      timestamp: ts,
      location: const LatLng(latitude: 42.36, longitude: -70.55),
      locationSource: LocationSource.phoneGps,
      speciesId: 'striped_bass',
      sizeClassId: 'slot',
      lengthInches: 29.5,
      weightPounds: 11.2,
      baitOrLure: 'live menhaden',
      released: true,
      notes: 'Hooked on the falling tide near the channel edge.',
      photoLocalPath: '/photos/$id.jpg',
      recommendationPinId: 'pin-3',
      conditions: const ConditionSnapshot(
        waterTempF: 62.0,
        depthFt: 18.0,
        tideState: TideState(
          phase: TidePhase.falling,
          toNextChange: Duration(hours: 1, minutes: 15),
          amplitudeFt: 4.2,
        ),
        wind: WindVector(speedKnots: 8, directionDegrees: 220),
      ),
      engineScoreAtCatch: 8.4,
      engineReasoningAtCatch: const ReasoningBreakdown(
        baseProbability: 0.7,
        gates: [GateResult(name: 'Migration presence', passed: true)],
        modifiers: [
          ModifierApplication(
            name: 'Tide phase',
            value: 1.1,
            rangeMin: 0.5,
            rangeMax: 1.5,
            description: 'Falling — favoured.',
          ),
        ],
        contributors: [
          ContributorApplication(
            name: 'Personal history',
            value: 0.9,
            rangeMax: 2.0,
            description: 'Two prior catches within 0.25 nm.',
          ),
        ],
        rawScoreBeforeContributors: 7.7,
        additiveTotal: 0.9,
        finalScore: 8.4,
        migrationSummary: 'Spring run, Chesapeake migrants present.',
        suggestedApproach: 'Live eels at the channel edge on the falling.',
      ),
      createdAt: ts.add(const Duration(seconds: 5)),
      updatedAt: ts.add(const Duration(seconds: 5)),
    );

void main() {
  // sqlite3 missing on this host? Skip every test in the group with a
  // human-readable reason; CI on Linux finds libsqlite3 system-wide.
  final skipReason = setupSqlite3();

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  // Phase 2 DoD §3.3: "CRUD operations on catches and trip_plans round-trip
  // without data loss."
  test(
    'CatchRecord round-trips through SQLite without data loss',
    () async {
      final original = _decoratedCatch(
        id: 'catch-001',
        ts: DateTime.utc(2026, 5, 22, 18, 30),
      );

      await db.catchesDao.upsert(original);
      final restored = await db.catchesDao.getById('catch-001');

      expect(restored, isNotNull);
      expect(restored, original);
    },
    skip: skipReason,
  );

  test(
    'upsert with the same id replaces (no duplicate rows)',
    () async {
      final original = _decoratedCatch(
        id: 'catch-001',
        ts: DateTime.utc(2026, 5, 22, 18, 30),
      );
      await db.catchesDao.upsert(original);

      final updated = original.copyWith(notes: 'edited note');
      await db.catchesDao.upsert(updated);

      final all = await db.catchesDao.getAll();
      expect(all, hasLength(1));
      expect(all.single.notes, 'edited note');
    },
    skip: skipReason,
  );

  test(
    'getAll returns catches newest-first',
    () async {
      final older = _decoratedCatch(
        id: 'older',
        ts: DateTime.utc(2026, 5, 1, 12),
      );
      final newer = _decoratedCatch(
        id: 'newer',
        ts: DateTime.utc(2026, 5, 22, 18),
      );
      await db.catchesDao.upsert(older);
      await db.catchesDao.upsert(newer);

      final all = await db.catchesDao.getAll();
      expect(all.map((c) => c.id), ['newer', 'older']);
    },
    skip: skipReason,
  );

  test(
    'deleteById removes only the targeted row',
    () async {
      final a = _decoratedCatch(id: 'a', ts: DateTime.utc(2026, 5, 22, 18));
      final b = _decoratedCatch(id: 'b', ts: DateTime.utc(2026, 5, 23, 18));
      await db.catchesDao.upsert(a);
      await db.catchesDao.upsert(b);

      final removed = await db.catchesDao.deleteById('a');
      expect(removed, 1);

      final all = await db.catchesDao.getAll();
      expect(all.map((c) => c.id), ['b']);
    },
    skip: skipReason,
  );

  test(
    'watchAll emits on insert',
    () async {
      final stream = db.catchesDao.watchAll();
      final emissions = <List<CatchRecord>>[];
      final sub = stream.listen(emissions.add);

      await Future<void>.delayed(const Duration(milliseconds: 10));
      await db.catchesDao.upsert(
        _decoratedCatch(
          id: 'streamed',
          ts: DateTime.utc(2026, 5, 22, 18),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));

      await sub.cancel();
      expect(emissions, isNotEmpty);
      expect(emissions.last.map((c) => c.id), ['streamed']);
    },
    skip: skipReason,
  );

  test(
    'the initial schema version is 1',
    () {
      expect(db.schemaVersion, 1);
    },
    // schemaVersion getter doesn't actually open SQLite; never skip.
  );
}

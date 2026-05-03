import 'package:ai_marine_engine/core/types/user_preferences.dart';
import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

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
    'getPreferences returns null on a fresh database',
    () async {
      expect(await db.userPreferencesDao.getPreferences(), isNull);
    },
    skip: skipReason,
  );

  test(
    'upsert + getPreferences round-trip preserves all fields',
    () async {
      final original = UserPreferences(
        updatedAt: DateTime.utc(2026, 5, 22, 18, 0),
        homeRegionId: 'mass_bay',
        primarySpeciesId: 'striped_bass',
        units: UnitSystem.metric,
        privacyOptInAggregate: true,
        cacheBudgetMb: 1024,
        useNmea2000WhenAvailable: true,
        gatewayConfigJson: '{"gatewayId":"vesper-01"}',
      );
      await db.userPreferencesDao.upsert(original);
      final restored = await db.userPreferencesDao.getPreferences();
      expect(restored, original);
    },
    skip: skipReason,
  );

  test(
    'upsert replaces (single-row invariant)',
    () async {
      final first = UserPreferences(
        updatedAt: DateTime.utc(2026, 5, 22, 18, 0),
        primarySpeciesId: 'striped_bass',
      );
      await db.userPreferencesDao.upsert(first);
      final second = first.copyWith(primarySpeciesId: 'fluke');
      await db.userPreferencesDao.upsert(second);
      final restored = await db.userPreferencesDao.getPreferences();
      expect(restored?.primarySpeciesId, 'fluke');
    },
    skip: skipReason,
  );
}

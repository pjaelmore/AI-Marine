import 'package:ai_marine_engine/core/types/user_preferences.dart';
import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:ai_marine_engine/state/infrastructure_providers.dart';
import 'package:ai_marine_engine/state/preferences_providers.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

void main() {
  final skipReason = setupSqlite3();
  late ProviderContainer container;
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test(
    'fresh database yields default preferences',
    () async {
      final notifier = container.read(userPreferencesProvider.notifier);
      await notifier.loaded;
      final state = container.read(userPreferencesProvider);
      expect(state.units, UnitSystem.imperial);
      expect(state.cacheBudgetMb, 500);
      expect(state.privacyOptInAggregate, isFalse);
      expect(state.useNmea2000WhenAvailable, isFalse);
    },
    skip: skipReason,
  );

  test(
    'setUnits updates state and persists through the DAO',
    () async {
      final notifier = container.read(userPreferencesProvider.notifier);
      await notifier.loaded;

      await notifier.setUnits(UnitSystem.metric);

      // Local state reflects the change.
      expect(
        container.read(userPreferencesProvider).units,
        UnitSystem.metric,
      );

      // A fresh container reading the same DB should see the persisted value.
      final container2 = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)],
      );
      addTearDown(container2.dispose);
      final notifier2 = container2.read(userPreferencesProvider.notifier);
      await notifier2.loaded;
      expect(
        container2.read(userPreferencesProvider).units,
        UnitSystem.metric,
      );
    },
    skip: skipReason,
  );

  test(
    'setPrimarySpecies persists a nullable id',
    () async {
      final notifier = container.read(userPreferencesProvider.notifier);
      await notifier.loaded;

      await notifier.setPrimarySpecies('striped_bass');
      expect(
        container.read(userPreferencesProvider).primarySpeciesId,
        'striped_bass',
      );

      await notifier.setPrimarySpecies(null);
      expect(
        container.read(userPreferencesProvider).primarySpeciesId,
        isNull,
      );
    },
    skip: skipReason,
  );

  test(
    'every setter stamps a new updatedAt',
    () async {
      final notifier = container.read(userPreferencesProvider.notifier);
      await notifier.loaded;
      final beforeSetter = container.read(userPreferencesProvider).updatedAt;

      // Tiny delay so the new timestamp is strictly later than the default.
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await notifier.setCacheBudgetMb(1024);

      final after = container.read(userPreferencesProvider).updatedAt;
      expect(after.isAfter(beforeSetter), isTrue);
    },
    skip: skipReason,
  );
}

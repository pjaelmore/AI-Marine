import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/types/user_preferences.dart';
import '../data/database/app_database.dart';
import 'infrastructure_providers.dart';

/// Default preferences shown before the database load completes (or for
/// the very-first launch when no row has been written yet). Matches the
/// §4.1.3 SQL column defaults: imperial units, no privacy opt-in, 500 MB
/// cache budget, NMEA off.
UserPreferences _defaultPreferences() =>
    UserPreferences(updatedAt: DateTime.now().toUtc());

/// Reactive user-preferences state — TDD §9.2.5.
///
/// Initial state is the §4.1.3 defaults; the constructor immediately
/// kicks off [_load] to read the stored row from SQLite. Setters apply
/// `copyWith` to local state and persist via the DAO; the next read on
/// any device sees the new value because the DAO writes the singleton
/// row in place.
///
/// Tests can `await notifier.loaded` to ensure the initial DB read has
/// finished before asserting on state.
class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier(this._db) : super(_defaultPreferences()) {
    loaded = _load();
  }

  final AppDatabase _db;
  late final Future<void> loaded;

  Future<void> _load() async {
    final stored = await _db.userPreferencesDao.getPreferences();
    if (stored != null) state = stored;
  }

  Future<void> setUnits(UnitSystem units) =>
      _update(state.copyWith(units: units));

  Future<void> setPrimarySpecies(String? speciesId) =>
      _update(state.copyWith(primarySpeciesId: speciesId));

  Future<void> setHomeRegion(String? regionId) =>
      _update(state.copyWith(homeRegionId: regionId));

  Future<void> setPrivacyOptInAggregate({required bool optedIn}) =>
      _update(state.copyWith(privacyOptInAggregate: optedIn));

  Future<void> setCacheBudgetMb(int megabytes) =>
      _update(state.copyWith(cacheBudgetMb: megabytes));

  Future<void> setUseNmea2000WhenAvailable({required bool enabled}) =>
      _update(state.copyWith(useNmea2000WhenAvailable: enabled));

  Future<void> _update(UserPreferences next) async {
    final stamped = next.copyWith(updatedAt: DateTime.now().toUtc());
    state = stamped;
    await _db.userPreferencesDao.upsert(stamped);
  }
}

final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, UserPreferences>(
  (ref) => UserPreferencesNotifier(ref.watch(databaseProvider)),
);

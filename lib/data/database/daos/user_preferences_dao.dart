import 'package:drift/drift.dart';

import '../../../core/types/user_preferences.dart';
import '../app_database.dart';
import '../tables/user_preferences.dart';

part 'user_preferences_dao.g.dart';

/// Single-row settings DAO. The fixed `id = 1` invariant for the
/// `user_preferences` table (TDD §4.1.3) is enforced here in upsert;
/// callers cannot pick another id.
///
/// Surfaces the [UserPreferences] value type rather than the Drift row
/// so callers (notably `UserPreferencesNotifier` in TDD §9.2.5) work
/// against the freezed type with `copyWith`, equality, etc.
@DriftAccessor(tables: [UserPreferencesTable])
class UserPreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$UserPreferencesDaoMixin {
  UserPreferencesDao(super.db);

  static const _singletonId = 1;

  /// Returns the stored preferences, or `null` if no row has been written
  /// yet (the very-first launch case — caller falls back to defaults).
  Future<UserPreferences?> getPreferences() async {
    final row = await (select(userPreferencesTable)
          ..where((t) => t.id.equals(_singletonId)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  /// Inserts or replaces the singleton preferences row with [prefs].
  Future<void> upsert(UserPreferences prefs) =>
      into(userPreferencesTable).insertOnConflictUpdate(_toCompanion(prefs));
}

UserPreferencesTableCompanion _toCompanion(UserPreferences p) =>
    UserPreferencesTableCompanion(
      id: const Value(1),
      homeRegionId: Value(p.homeRegionId),
      primarySpeciesId: Value(p.primarySpeciesId),
      units: Value(p.units.name),
      privacyOptInAggregate: Value(p.privacyOptInAggregate),
      cacheBudgetMb: Value(p.cacheBudgetMb),
      useNmea2000WhenAvailable: Value(p.useNmea2000WhenAvailable),
      gatewayConfigJson: Value(p.gatewayConfigJson),
      updatedAtUtc: Value(p.updatedAt.toUtc().millisecondsSinceEpoch),
    );

UserPreferences _fromRow(UserPreferencesRow r) => UserPreferences(
      updatedAt:
          DateTime.fromMillisecondsSinceEpoch(r.updatedAtUtc, isUtc: true),
      homeRegionId: r.homeRegionId,
      primarySpeciesId: r.primarySpeciesId,
      units: UnitSystem.values.byName(r.units),
      privacyOptInAggregate: r.privacyOptInAggregate,
      cacheBudgetMb: r.cacheBudgetMb,
      useNmea2000WhenAvailable: r.useNmea2000WhenAvailable,
      gatewayConfigJson: r.gatewayConfigJson,
    );

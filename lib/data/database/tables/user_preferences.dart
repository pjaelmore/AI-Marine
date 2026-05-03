import 'package:drift/drift.dart';

/// Single-row user settings — TDD §4.1.3.
///
/// SQL has `id INTEGER PRIMARY KEY CHECK (id = 1)`; Drift's table-level
/// CHECK constraint requires self-referential SQL that doesn't compose
/// cleanly through Drift's column DSL. The DAO is the sole writer and
/// always upserts with `id = 1`, so the invariant is maintained at the
/// access layer instead of the schema layer — adequate for v1.
///
/// Class name `UserPreferencesTable` (rather than `UserPreferences`)
/// avoids clashing with the freezed value type
/// `core/types/user_preferences.dart` which the DAO surfaces.
@DataClassName('UserPreferencesRow')
class UserPreferencesTable extends Table {
  @override
  String? get tableName => 'user_preferences';

  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get homeRegionId => text().nullable()();
  TextColumn get primarySpeciesId => text().nullable()();
  TextColumn get units => text().withDefault(const Constant('imperial'))();
  BoolColumn get privacyOptInAggregate =>
      boolean().withDefault(const Constant(false))();
  IntColumn get cacheBudgetMb => integer().withDefault(const Constant(500))();
  BoolColumn get useNmea2000WhenAvailable =>
      boolean().withDefault(const Constant(false))();
  TextColumn get gatewayConfigJson => text().nullable()();
  IntColumn get updatedAtUtc => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

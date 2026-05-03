import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';
part 'user_preferences.g.dart';

/// Imperial vs metric — propagates throughout the UI per Settings (TDD §10.6).
enum UnitSystem { imperial, metric }

/// Single-row user settings backing the §4.1.3 `user_preferences` table.
///
/// TDD §9.2.5 uses a `UserPreferences` Dart type for the
/// `UserPreferencesNotifier` state but does not define the class in §3;
/// shape inferred from the §4.1.3 SQL columns. Same kind of spec gap as
/// `NamedFeature` and `ScoreResult`; documented inline.
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    required DateTime updatedAt,
    String? homeRegionId,
    String? primarySpeciesId,
    @Default(UnitSystem.imperial) UnitSystem units,
    @Default(false) bool privacyOptInAggregate,
    @Default(500) int cacheBudgetMb,
    @Default(false) bool useNmea2000WhenAvailable,
    String? gatewayConfigJson,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

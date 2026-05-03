import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/types/lat_lng.dart';
import '../../../core/utils/time.dart';

part 'migration_model.freezed.dart';
part 'migration_model.g.dart';

/// How a species moves through space and time across the year.
///
/// Mirrors TDD §3.3.2. The shape is data-driven: the model carries no
/// behaviour beyond [RegionalPresenceCurve.presenceAt]; engine logic that
/// consumes it (the migration-presence gate, migration-corridor contributor)
/// lives elsewhere and reads from these structures.
@freezed
class MigrationModel with _$MigrationModel {
  const factory MigrationModel({
    required GeoPolygon spatialRange,
    @Default(<Population>[]) List<Population> populations,
    @Default(<RegionalPresenceCurve>[])
    List<RegionalPresenceCurve> regionalCurves,
    @Default(<MigrationCorridor>[]) List<MigrationCorridor> corridors,
    @Default(<TriggerRule>[]) List<TriggerRule> triggers,
  }) = _MigrationModel;

  factory MigrationModel.fromJson(Map<String, dynamic> json) =>
      _$MigrationModelFromJson(json);
}

/// A breeding population whose seasonal movements are partially independent
/// from sibling populations of the same species (e.g. Hudson River vs
/// Chesapeake Bay striped bass).
@freezed
class Population with _$Population {
  const factory Population({
    required String id,
    required String displayName,
    required String description,
    @Default(<String>[]) List<String> regionIds,
  }) = _Population;

  factory Population.fromJson(Map<String, dynamic> json) =>
      _$PopulationFromJson(json);
}

/// Per-region likelihood that any individuals are present, indexed by week
/// of year. [weeklyValues] must have length 52 with each entry in [0, 1];
/// validation belongs to the species-data loader (Phase 5), not this type.
@freezed
class RegionalPresenceCurve with _$RegionalPresenceCurve {
  const RegionalPresenceCurve._();

  const factory RegionalPresenceCurve({
    required String regionId,
    required GeoPolygon regionPolygon,
    required List<double> weeklyValues,
  }) = _RegionalPresenceCurve;

  factory RegionalPresenceCurve.fromJson(Map<String, dynamic> json) =>
      _$RegionalPresenceCurveFromJson(json);

  /// Presence likelihood at [time]. Returns 0 when the curve is empty —
  /// defensive default so a malformed curve degrades to "no presence"
  /// rather than crashing the engine.
  double presenceAt(DateTime time) {
    if (weeklyValues.isEmpty) return 0;
    final week = weekOfYear(time);
    final idx = (week - 1).clamp(0, weeklyValues.length - 1);
    return weeklyValues[idx];
  }
}

/// A directional movement path between regions. The corridor is "active"
/// during weeks [activeWeekStart] through [activeWeekEnd] inclusive, with
/// a swept width of [widthNm] nm centred on the path.
@freezed
class MigrationCorridor with _$MigrationCorridor {
  const factory MigrationCorridor({
    required String id,
    required List<LatLng> path,
    required double widthNm,
    required int activeWeekStart,
    required int activeWeekEnd,
  }) = _MigrationCorridor;

  factory MigrationCorridor.fromJson(Map<String, dynamic> json) =>
      _$MigrationCorridorFromJson(json);
}

/// External-event trigger that adjusts migration timing — sea-surface
/// temperature anomalies, photoperiod thresholds, baitfish presence, or
/// custom rules. [parameters] is intentionally open-ended so new trigger
/// kinds can ship in species data without code changes.
enum TriggerKind {
  sstAnomalyShift,
  photoperiodThreshold,
  baitfishPresenceModifier,
  custom,
}

@freezed
class TriggerRule with _$TriggerRule {
  const factory TriggerRule({
    required String id,
    required TriggerKind kind,
    @Default(<String, dynamic>{}) Map<String, dynamic> parameters,
  }) = _TriggerRule;

  factory TriggerRule.fromJson(Map<String, dynamic> json) =>
      _$TriggerRuleFromJson(json);
}

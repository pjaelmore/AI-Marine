import 'package:freezed_annotation/freezed_annotation.dart';

import 'conditions.dart';
import 'lat_lng.dart';
import 'score_result.dart';

part 'catch_record.freezed.dart';
part 'catch_record.g.dart';

/// How the location attached to a catch was determined. Matches the
/// `location_source` CHECK constraint in `app.catches` (TDD §4.2.2) and
/// the `LocationSource` enum referenced by §9.2.2 vessel-position stream.
enum LocationSource { phoneGps, nmea2000, manual, lastKnown }

/// Frozen snapshot of conditions at the moment a catch was logged. Each
/// field is nullable so partial captures (a missing buoy reading, no
/// solunar data, etc.) round-trip without rewriting the catch. Mirrors
/// TDD §3.4.
@freezed
class ConditionSnapshot with _$ConditionSnapshot {
  const factory ConditionSnapshot({
    double? waterTempF,
    double? depthFt,
    TideState? tideState,
    SolunarState? solunarState,
    WindVector? wind,
    WaveState? waves,
    BarometricState? barometric,
    MoonPhase? moonPhase,
    String? weatherSummary,
  }) = _ConditionSnapshot;

  factory ConditionSnapshot.fromJson(Map<String, dynamic> json) =>
      _$ConditionSnapshotFromJson(json);
}

/// One logged catch. Mirrors TDD §3.4 plus the `app.catches` Postgres
/// schema in §4.2.2; the on-device SQLite schema in §4.1.2 carries the
/// same columns.
///
/// `conditions` and the optional `engineScoreAtCatch` /
/// `engineReasoningAtCatch` are auto-captured at log time (TDD §2.4) so
/// every entry can later answer "what was happening, and what did the
/// engine think, when this fish was caught."
@freezed
class CatchRecord with _$CatchRecord {
  const factory CatchRecord({
    required String id,
    required String userId,
    required DateTime timestamp,
    required LatLng location,
    required LocationSource locationSource,
    required String speciesId,
    required ConditionSnapshot conditions,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? sizeClassId,
    double? lengthInches,
    double? weightPounds,
    String? baitOrLure,
    bool? released,
    String? notes,
    String? photoLocalPath,
    String? recommendationPinId,
    double? engineScoreAtCatch,
    ReasoningBreakdown? engineReasoningAtCatch,
  }) = _CatchRecord;

  factory CatchRecord.fromJson(Map<String, dynamic> json) =>
      _$CatchRecordFromJson(json);
}

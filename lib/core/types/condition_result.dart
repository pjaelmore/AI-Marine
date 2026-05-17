import 'package:freezed_annotation/freezed_annotation.dart';

part 'condition_result.freezed.dart';
part 'condition_result.g.dart';

/// Origin of a condition value, used to drive the mode indicator (TDD
/// §10.2.4) and confidence weighting (TDD §2.1.4).
enum DataSource {
  noaaNdbc,
  noaaTidesAndCurrents,
  noaaMarineForecast,
  noaaEnc,
  noaaCoastWatchSst, // Phase 2
  openMeteoMarine,
  nmea2000Gateway, // Phase 2
  computedLocal,
  cached,
  interpolated,
  unavailable,
}

/// Which cache layer satisfied a request, when one did. Null when the
/// value came directly from a live source or computation.
enum CacheLayer { liveSensor, hot, warm, cold }

/// Provenance details that travel alongside a [ConditionResult]. None of
/// the fields are required because different sources surface different
/// metadata — a buoy reading carries [stationId], an interpolated value
/// carries [interpolationDistanceNm], a cache hit carries [cacheHitLayer].
@freezed
class SourceDetails with _$SourceDetails {
  const factory SourceDetails({
    String? stationId,
    String? gatewayId,
    CacheLayer? cacheHitLayer,
    String? noaaZoneId,
    double? interpolationDistanceNm,
  }) = _SourceDetails;

  factory SourceDetails.fromJson(Map<String, dynamic> json) =>
      _$SourceDetailsFromJson(json);
}

/// Result wrapper carrying a condition value plus provenance metadata.
/// Mirrors TDD §2.1.1.
///
/// Generic over [T] so the same wrapper handles `double` (water temp,
/// depth), `TideState`, `WindVector`, etc. JSON serialisation is not
/// supported on the generic envelope itself — `json_serializable` can't
/// codegen a generic `fromJson` without per-T factories. v1 never
/// persists `ConditionResult` instances; the cache layer in Phase 4
/// stores raw values and re-wraps on read.
@freezed
class ConditionResult<T> with _$ConditionResult<T> {
  const factory ConditionResult({
    required T value,
    required String unit,
    required DataSource source,
    required SourceDetails sourceDetails,
    required DateTime fetchedAt,
    required DateTime validUntil,
    required double confidence,

    /// When the *underlying observation* was recorded. Distinct from
    /// [fetchedAt] (when we hit the API) because NDBC buoys report in
    /// 10-minute cadence so the most recent row can already be ~50
    /// minutes old by the time the cache walks the realtime2 feed.
    /// Null when no upstream timestamp exists (e.g. solunar — pure
    /// local computation — or the unavailable sentinel).
    DateTime? observedAt,
  }) = _ConditionResult<T>;

  /// Sentinel result for "no source could satisfy this query."
  ///
  /// TDD §2.1.3 specifies a unit-appropriate sentinel as [value] —
  /// `double.nan` for doubles, `null` for nullable types — paired with
  /// `DataSource.unavailable` and `confidence: 0.0`. The Probability
  /// Calculator suppresses any modifier whose input arrives this way.
  factory ConditionResult.unavailable({
    required T value,
    required DateTime time,
    String unit = '',
  }) {
    return ConditionResult<T>(
      value: value,
      unit: unit,
      source: DataSource.unavailable,
      sourceDetails: const SourceDetails(),
      fetchedAt: time,
      validUntil: time,
      confidence: 0,
    );
  }
}

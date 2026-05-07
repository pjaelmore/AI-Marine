import 'package:freezed_annotation/freezed_annotation.dart';

import 'lat_lng.dart';

part 'trip_plan.freezed.dart';
part 'trip_plan.g.dart';

/// User-saved trip plan — the canonical app-level model that the
/// "Plan a trip" UI writes (slice 13a) and the trip-aware overlays
/// (offline tile cache, score-grid pre-compute, connectivity badges)
/// read.
///
/// Wraps the Drift `TripPlanRow` shape with proper [LatLng] bounds and
/// `DateTime` timestamps; `TripPlansRepository` does the row ↔ value
/// conversion. Persisted in the `trip_plans` table.
///
/// `cacheStatus` is a small structured wrapper around the table's
/// generic `cacheStatusJson` text column — its keys grow as later
/// trip-planning slices come online (`rampId` for the launch anchor,
/// `tilesDownloaded` once 13b runs, `scoreGridReady` once 13d runs).
@freezed
class TripPlan with _$TripPlan {
  const TripPlan._();

  const factory TripPlan({
    required String id,
    required String name,
    required LatLngBounds bounds,
    required DateTime plannedStart,
    required DateTime plannedEnd,
    required String targetSpeciesId,
    required DateTime createdAt,
    @Default(TripCacheStatus()) TripCacheStatus cacheStatus,
    String? userId,
  }) = _TripPlan;

  factory TripPlan.fromJson(Map<String, dynamic> json) =>
      _$TripPlanFromJson(json);

  /// Geometric centre of the trip area — used as the initial camera
  /// target when the user activates a saved trip.
  LatLng get center => bounds.center;

  /// Whether [time] falls inside the plan's window (inclusive of
  /// edges). Used by the offline-stale UX to decide whether cached
  /// data is "still relevant" for the current trip.
  bool containsTime(DateTime time) =>
      !time.isBefore(plannedStart) && !time.isAfter(plannedEnd);
}

/// Pre-trip pre-fetch progress + ramp anchor, encoded into the trip
/// row's `cacheStatusJson` text column. Keeping it freezed lets us
/// extend keys (tile coverage %, score grid resolution) without
/// touching the Drift schema — the column stays a generic JSON blob.
@freezed
class TripCacheStatus with _$TripCacheStatus {
  const factory TripCacheStatus({
    /// OSM boat-ramp id the user picked as the trip's launch anchor.
    /// Persisted here rather than as a first-class column so the
    /// `trip_plans` table stays generic until Phase 7 settles the
    /// pre-trip schema.
    String? rampId,

    /// Whether tiles for `bounds` at the configured zoom range have
    /// been downloaded. Set true by the 13b tile downloader once a
    /// pass completes.
    @Default(false) bool tilesDownloaded,

    /// Whether the score grid for `bounds` × `targetSpeciesId` ×
    /// `plannedStart` has been pre-computed. Set true by 13d.
    @Default(false) bool scoreGridReady,
  }) = _TripCacheStatus;

  factory TripCacheStatus.fromJson(Map<String, dynamic> json) =>
      _$TripCacheStatusFromJson(json);
}

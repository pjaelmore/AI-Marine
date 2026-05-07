import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/types/lat_lng.dart';

part 'boat_ramp_record.freezed.dart';
part 'boat_ramp_record.g.dart';

/// One OSM-derived boat ramp — `leisure=slipway` or `amenity=boat_ramp`
/// pulled by `scripts/refresh_osm_ramps.dart` from the Overpass API
/// and bundled at `assets/osm_ramps.json`. Used as the trip-anchor in
/// the trip-planner UX (slice 13a) — pick a ramp, define the fishable
/// bbox around it.
///
/// `id` is the OSM element identifier — `node/12345` or `way/67890`.
/// `name`, `access`, `fee`, and `surface` are all optional because OSM
/// ramp tagging is sparse — most entries are just `leisure=slipway`
/// at a coordinate.
@freezed
class BoatRampRecord with _$BoatRampRecord {
  const BoatRampRecord._();

  const factory BoatRampRecord({
    required String id,
    required double lat,
    required double lon,
    String? name,

    /// OSM access tag — typically `yes`, `permissive`, `customers`,
    /// `permit`, or null when unset. Explicit `private` ramps are
    /// filtered out at refresh time (trip planning is public-launch).
    String? access,

    /// `yes` / `no` / null. Whether the ramp charges a launch fee.
    String? fee,

    /// `concrete`, `asphalt`, `gravel`, `grass`, etc. — null when
    /// unset upstream.
    String? surface,
  }) = _BoatRampRecord;

  factory BoatRampRecord.fromJson(Map<String, dynamic> json) =>
      _$BoatRampRecordFromJson(json);

  /// Coordinate as a [LatLng] for haversine distance against a query
  /// point (e.g. tap location, vessel position).
  LatLng get location => LatLng(latitude: lat, longitude: lon);

  /// Great-circle distance from this ramp to [other], in nautical
  /// miles.
  double distanceNmTo(LatLng other) => location.distanceTo(other);
}

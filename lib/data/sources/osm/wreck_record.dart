import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/types/lat_lng.dart';

part 'wreck_record.freezed.dart';
part 'wreck_record.g.dart';

/// One OpenStreetMap-derived wreck — `seamark:type=wreck` features
/// pulled by `scripts/refresh_osm_wrecks.dart` from the Overpass API
/// and bundled at `assets/osm_wrecks.json`. Coverage is community-
/// contributed and partial; chartplotter-grade comprehensive wrecks
/// require NOAA ENC data (v1.5+ MBTiles bundling).
///
/// `id` is the OSM element identifier — `node/12345` or `way/67890`.
/// `name`, `category`, and `depthM` are all optional because OSM tags
/// are inconsistently populated in the wild.
@freezed
class WreckRecord with _$WreckRecord {
  const WreckRecord._();

  const factory WreckRecord({
    required String id,
    required double lat,
    required double lon,
    String? name,

    /// Seamark wreck category — typically `dangerous`, `non-dangerous`,
    /// `distributed_remains`, or null when unset upstream.
    String? category,

    /// Charted wreck depth (top of wreck, in metres). Often null.
    double? depthM,
  }) = _WreckRecord;

  factory WreckRecord.fromJson(Map<String, dynamic> json) =>
      _$WreckRecordFromJson(json);

  /// Coordinate as a [LatLng] for haversine distance against a query
  /// point.
  LatLng get location => LatLng(latitude: lat, longitude: lon);

  /// Great-circle distance from this wreck to [other], in nautical
  /// miles.
  double distanceNmTo(LatLng other) => location.distanceTo(other);
}

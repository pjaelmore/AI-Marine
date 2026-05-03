import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/types/lat_lng.dart';

part 'buoy_station.freezed.dart';
part 'buoy_station.g.dart';

/// One bundled NDBC buoy station — TDD §5.2.4. The list ships at
/// `assets/ndbc_stations.json` and is updated with each app release.
@freezed
class BuoyStation with _$BuoyStation {
  const BuoyStation._();

  const factory BuoyStation({
    required String id,
    required String name,
    required double lat,
    required double lon,
  }) = _BuoyStation;

  factory BuoyStation.fromJson(Map<String, dynamic> json) =>
      _$BuoyStationFromJson(json);

  /// Coordinate as a [LatLng] for haversine distance against a query
  /// point.
  LatLng get location => LatLng(latitude: lat, longitude: lon);

  /// Great-circle distance from this station to [other], in nautical miles.
  double distanceNmTo(LatLng other) => location.distanceTo(other);
}

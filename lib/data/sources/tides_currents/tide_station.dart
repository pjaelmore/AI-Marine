import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/types/lat_lng.dart';

part 'tide_station.freezed.dart';
part 'tide_station.g.dart';

/// One bundled NOAA Tides & Currents station — TDD §5.3. The list ships
/// at `assets/tide_stations.json` and is updated with app releases.
@freezed
class TideStation with _$TideStation {
  const TideStation._();

  const factory TideStation({
    required String id,
    required String name,
    required double lat,
    required double lon,
  }) = _TideStation;

  factory TideStation.fromJson(Map<String, dynamic> json) =>
      _$TideStationFromJson(json);

  LatLng get location => LatLng(latitude: lat, longitude: lon);

  double distanceNmTo(LatLng other) => location.distanceTo(other);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lat_lng.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LatLngImpl _$$LatLngImplFromJson(Map<String, dynamic> json) => _$LatLngImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$LatLngImplToJson(_$LatLngImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$LatLngBoundsImpl _$$LatLngBoundsImplFromJson(Map<String, dynamic> json) =>
    _$LatLngBoundsImpl(
      southwest: LatLng.fromJson(json['southwest'] as Map<String, dynamic>),
      northeast: LatLng.fromJson(json['northeast'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LatLngBoundsImplToJson(_$LatLngBoundsImpl instance) =>
    <String, dynamic>{
      'southwest': instance.southwest.toJson(),
      'northeast': instance.northeast.toJson(),
    };

_$GeoPolygonImpl _$$GeoPolygonImplFromJson(Map<String, dynamic> json) =>
    _$GeoPolygonImpl(
      rings: (json['rings'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => LatLng.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$GeoPolygonImplToJson(_$GeoPolygonImpl instance) =>
    <String, dynamic>{
      'rings':
          instance.rings.map((e) => e.map((e) => e.toJson()).toList()).toList(),
    };

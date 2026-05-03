// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tide_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TideStationImpl _$$TideStationImplFromJson(Map<String, dynamic> json) =>
    _$TideStationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$$TideStationImplToJson(_$TideStationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
    };

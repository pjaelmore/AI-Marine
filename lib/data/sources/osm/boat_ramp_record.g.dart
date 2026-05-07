// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boat_ramp_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoatRampRecordImpl _$$BoatRampRecordImplFromJson(Map<String, dynamic> json) =>
    _$BoatRampRecordImpl(
      id: json['id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      name: json['name'] as String?,
      access: json['access'] as String?,
      fee: json['fee'] as String?,
      surface: json['surface'] as String?,
    );

Map<String, dynamic> _$$BoatRampRecordImplToJson(
        _$BoatRampRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lon': instance.lon,
      'name': instance.name,
      'access': instance.access,
      'fee': instance.fee,
      'surface': instance.surface,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wreck_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WreckRecordImpl _$$WreckRecordImplFromJson(Map<String, dynamic> json) =>
    _$WreckRecordImpl(
      id: json['id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      name: json['name'] as String?,
      category: json['category'] as String?,
      depthM: (json['depthM'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WreckRecordImplToJson(_$WreckRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lon': instance.lon,
      'name': instance.name,
      'category': instance.category,
      'depthM': instance.depthM,
    };

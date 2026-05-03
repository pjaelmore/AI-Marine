// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SourceDetailsImpl _$$SourceDetailsImplFromJson(Map<String, dynamic> json) =>
    _$SourceDetailsImpl(
      stationId: json['stationId'] as String?,
      gatewayId: json['gatewayId'] as String?,
      cacheHitLayer:
          $enumDecodeNullable(_$CacheLayerEnumMap, json['cacheHitLayer']),
      noaaZoneId: json['noaaZoneId'] as String?,
      interpolationDistanceNm:
          (json['interpolationDistanceNm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SourceDetailsImplToJson(_$SourceDetailsImpl instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'gatewayId': instance.gatewayId,
      'cacheHitLayer': _$CacheLayerEnumMap[instance.cacheHitLayer],
      'noaaZoneId': instance.noaaZoneId,
      'interpolationDistanceNm': instance.interpolationDistanceNm,
    };

const _$CacheLayerEnumMap = {
  CacheLayer.liveSensor: 'liveSensor',
  CacheLayer.hot: 'hot',
  CacheLayer.warm: 'warm',
  CacheLayer.cold: 'cold',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buoy_observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BuoyObservationImpl _$$BuoyObservationImplFromJson(
        Map<String, dynamic> json) =>
    _$BuoyObservationImpl(
      stationId: json['stationId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      waterTempC: (json['waterTempC'] as num?)?.toDouble(),
      airTempC: (json['airTempC'] as num?)?.toDouble(),
      windDirDegT: (json['windDirDegT'] as num?)?.toDouble(),
      windSpeedMps: (json['windSpeedMps'] as num?)?.toDouble(),
      gustMps: (json['gustMps'] as num?)?.toDouble(),
      waveHeightM: (json['waveHeightM'] as num?)?.toDouble(),
      dominantPeriodSec: (json['dominantPeriodSec'] as num?)?.toDouble(),
      pressureHpa: (json['pressureHpa'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$BuoyObservationImplToJson(
        _$BuoyObservationImpl instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'timestamp': instance.timestamp.toIso8601String(),
      'waterTempC': instance.waterTempC,
      'airTempC': instance.airTempC,
      'windDirDegT': instance.windDirDegT,
      'windSpeedMps': instance.windSpeedMps,
      'gustMps': instance.gustMps,
      'waveHeightM': instance.waveHeightM,
      'dominantPeriodSec': instance.dominantPeriodSec,
      'pressureHpa': instance.pressureHpa,
    };

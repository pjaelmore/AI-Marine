// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForecastPeriodImpl _$$ForecastPeriodImplFromJson(Map<String, dynamic> json) =>
    _$ForecastPeriodImpl(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      temperatureUnit: json['temperatureUnit'] as String,
      windSpeedRaw: json['windSpeedRaw'] as String,
      windDirectionRaw: json['windDirectionRaw'] as String,
      shortForecast: json['shortForecast'] as String,
    );

Map<String, dynamic> _$$ForecastPeriodImplToJson(
        _$ForecastPeriodImpl instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'temperature': instance.temperature,
      'temperatureUnit': instance.temperatureUnit,
      'windSpeedRaw': instance.windSpeedRaw,
      'windDirectionRaw': instance.windDirectionRaw,
      'shortForecast': instance.shortForecast,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tide_prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TidePredictionImpl _$$TidePredictionImplFromJson(Map<String, dynamic> json) =>
    _$TidePredictionImpl(
      time: DateTime.parse(json['time'] as String),
      heightFt: (json['heightFt'] as num).toDouble(),
      type: $enumDecode(_$TideTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$TidePredictionImplToJson(
        _$TidePredictionImpl instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'heightFt': instance.heightFt,
      'type': _$TideTypeEnumMap[instance.type]!,
    };

const _$TideTypeEnumMap = {
  TideType.high: 'high',
  TideType.low: 'low',
};

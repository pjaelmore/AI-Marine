// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConditionProfileImpl _$$ConditionProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$ConditionProfileImpl(
      optimalTemp: TemperatureRange.fromJson(
          json['optimalTemp'] as Map<String, dynamic>),
      toleratedTemp: TemperatureRange.fromJson(
          json['toleratedTemp'] as Map<String, dynamic>),
      depthPreference: DepthPreference.fromJson(
          json['depthPreference'] as Map<String, dynamic>),
      structurePreferences: (json['structurePreferences'] as List<dynamic>?)
              ?.map((e) =>
                  StructurePreference.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <StructurePreference>[],
      tidePreference: TidePreference.fromJson(
          json['tidePreference'] as Map<String, dynamic>),
      solunarSensitivity:
          $enumDecode(_$SolunarSensitivityEnumMap, json['solunarSensitivity']),
      timeOfDayPreferences: (json['timeOfDayPreferences'] as List<dynamic>?)
              ?.map((e) =>
                  TimeOfDayPreference.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TimeOfDayPreference>[],
      lunarSensitivity:
          $enumDecode(_$LunarSensitivityEnumMap, json['lunarSensitivity']),
      weatherSensitivity: WeatherSensitivity.fromJson(
          json['weatherSensitivity'] as Map<String, dynamic>),
      salinityPreference: json['salinityPreference'] == null
          ? null
          : SalinityPreference.fromJson(
              json['salinityPreference'] as Map<String, dynamic>),
      currentPreference: CurrentPreference.fromJson(
          json['currentPreference'] as Map<String, dynamic>),
      baitAssociations: (json['baitAssociations'] as List<dynamic>?)
              ?.map((e) => BaitAssociation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BaitAssociation>[],
    );

Map<String, dynamic> _$$ConditionProfileImplToJson(
        _$ConditionProfileImpl instance) =>
    <String, dynamic>{
      'optimalTemp': instance.optimalTemp.toJson(),
      'toleratedTemp': instance.toleratedTemp.toJson(),
      'depthPreference': instance.depthPreference.toJson(),
      'structurePreferences':
          instance.structurePreferences.map((e) => e.toJson()).toList(),
      'tidePreference': instance.tidePreference.toJson(),
      'solunarSensitivity':
          _$SolunarSensitivityEnumMap[instance.solunarSensitivity]!,
      'timeOfDayPreferences':
          instance.timeOfDayPreferences.map((e) => e.toJson()).toList(),
      'lunarSensitivity': _$LunarSensitivityEnumMap[instance.lunarSensitivity]!,
      'weatherSensitivity': instance.weatherSensitivity.toJson(),
      'salinityPreference': instance.salinityPreference?.toJson(),
      'currentPreference': instance.currentPreference.toJson(),
      'baitAssociations':
          instance.baitAssociations.map((e) => e.toJson()).toList(),
    };

const _$SolunarSensitivityEnumMap = {
  SolunarSensitivity.none: 'none',
  SolunarSensitivity.low: 'low',
  SolunarSensitivity.medium: 'medium',
  SolunarSensitivity.high: 'high',
};

const _$LunarSensitivityEnumMap = {
  LunarSensitivity.none: 'none',
  LunarSensitivity.low: 'low',
  LunarSensitivity.medium: 'medium',
  LunarSensitivity.high: 'high',
};

_$TemperatureRangeImpl _$$TemperatureRangeImplFromJson(
        Map<String, dynamic> json) =>
    _$TemperatureRangeImpl(
      minF: (json['minF'] as num).toDouble(),
      maxF: (json['maxF'] as num).toDouble(),
      idealF: (json['idealF'] as num).toDouble(),
    );

Map<String, dynamic> _$$TemperatureRangeImplToJson(
        _$TemperatureRangeImpl instance) =>
    <String, dynamic>{
      'minF': instance.minF,
      'maxF': instance.maxF,
      'idealF': instance.idealF,
    };

_$DepthPreferenceImpl _$$DepthPreferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$DepthPreferenceImpl(
      minFt: (json['minFt'] as num).toDouble(),
      maxFt: (json['maxFt'] as num).toDouble(),
      idealFt: (json['idealFt'] as num).toDouble(),
    );

Map<String, dynamic> _$$DepthPreferenceImplToJson(
        _$DepthPreferenceImpl instance) =>
    <String, dynamic>{
      'minFt': instance.minFt,
      'maxFt': instance.maxFt,
      'idealFt': instance.idealFt,
    };

_$StructurePreferenceImpl _$$StructurePreferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$StructurePreferenceImpl(
      type: $enumDecode(_$StructureTypeEnumMap, json['type']),
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$$StructurePreferenceImplToJson(
        _$StructurePreferenceImpl instance) =>
    <String, dynamic>{
      'type': _$StructureTypeEnumMap[instance.type]!,
      'weight': instance.weight,
    };

const _$StructureTypeEnumMap = {
  StructureType.flatBottom: 'flatBottom',
  StructureType.sandFlat: 'sandFlat',
  StructureType.channel: 'channel',
  StructureType.channelEdge: 'channelEdge',
  StructureType.ledge: 'ledge',
  StructureType.dropOff: 'dropOff',
  StructureType.reef: 'reef',
  StructureType.wreck: 'wreck',
  StructureType.weedLine: 'weedLine',
  StructureType.shoal: 'shoal',
  StructureType.ripCurrent: 'ripCurrent',
  StructureType.unknown: 'unknown',
};

_$TidePreferenceImpl _$$TidePreferenceImplFromJson(Map<String, dynamic> json) =>
    _$TidePreferenceImpl(
      phaseWeights: (json['phaseWeights'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$TidePhaseEnumMap, k), (e as num).toDouble()),
      ),
      prefersSpringTides: json['prefersSpringTides'] as bool? ?? false,
    );

Map<String, dynamic> _$$TidePreferenceImplToJson(
        _$TidePreferenceImpl instance) =>
    <String, dynamic>{
      'phaseWeights': instance.phaseWeights
          .map((k, e) => MapEntry(_$TidePhaseEnumMap[k]!, e)),
      'prefersSpringTides': instance.prefersSpringTides,
    };

const _$TidePhaseEnumMap = {
  TidePhase.rising: 'rising',
  TidePhase.falling: 'falling',
  TidePhase.slackHigh: 'slackHigh',
  TidePhase.slackLow: 'slackLow',
};

_$TimeOfDayPreferenceImpl _$$TimeOfDayPreferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$TimeOfDayPreferenceImpl(
      startHour: (json['startHour'] as num).toInt(),
      endHour: (json['endHour'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$$TimeOfDayPreferenceImplToJson(
        _$TimeOfDayPreferenceImpl instance) =>
    <String, dynamic>{
      'startHour': instance.startHour,
      'endHour': instance.endHour,
      'weight': instance.weight,
    };

_$WeatherSensitivityImpl _$$WeatherSensitivityImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherSensitivityImpl(
      risingPressureFactor: (json['risingPressureFactor'] as num).toDouble(),
      fallingPressureFactor: (json['fallingPressureFactor'] as num).toDouble(),
      frontalPassageFactor: (json['frontalPassageFactor'] as num).toDouble(),
      cloudCoverPreference: (json['cloudCoverPreference'] as num).toDouble(),
    );

Map<String, dynamic> _$$WeatherSensitivityImplToJson(
        _$WeatherSensitivityImpl instance) =>
    <String, dynamic>{
      'risingPressureFactor': instance.risingPressureFactor,
      'fallingPressureFactor': instance.fallingPressureFactor,
      'frontalPassageFactor': instance.frontalPassageFactor,
      'cloudCoverPreference': instance.cloudCoverPreference,
    };

_$SalinityPreferenceImpl _$$SalinityPreferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$SalinityPreferenceImpl(
      minPpt: (json['minPpt'] as num).toDouble(),
      maxPpt: (json['maxPpt'] as num).toDouble(),
      idealPpt: (json['idealPpt'] as num).toDouble(),
    );

Map<String, dynamic> _$$SalinityPreferenceImplToJson(
        _$SalinityPreferenceImpl instance) =>
    <String, dynamic>{
      'minPpt': instance.minPpt,
      'maxPpt': instance.maxPpt,
      'idealPpt': instance.idealPpt,
    };

_$CurrentPreferenceImpl _$$CurrentPreferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$CurrentPreferenceImpl(
      minKnots: (json['minKnots'] as num).toDouble(),
      maxKnots: (json['maxKnots'] as num).toDouble(),
      idealKnots: (json['idealKnots'] as num).toDouble(),
    );

Map<String, dynamic> _$$CurrentPreferenceImplToJson(
        _$CurrentPreferenceImpl instance) =>
    <String, dynamic>{
      'minKnots': instance.minKnots,
      'maxKnots': instance.maxKnots,
      'idealKnots': instance.idealKnots,
    };

_$BaitAssociationImpl _$$BaitAssociationImplFromJson(
        Map<String, dynamic> json) =>
    _$BaitAssociationImpl(
      baitfish: json['baitfish'] as String,
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$$BaitAssociationImplToJson(
        _$BaitAssociationImpl instance) =>
    <String, dynamic>{
      'baitfish': instance.baitfish,
      'weight': instance.weight,
    };

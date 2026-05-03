// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TideStateImpl _$$TideStateImplFromJson(Map<String, dynamic> json) =>
    _$TideStateImpl(
      phase: $enumDecode(_$TidePhaseEnumMap, json['phase']),
      toNextChange:
          Duration(microseconds: (json['toNextChange'] as num).toInt()),
      amplitudeFt: (json['amplitudeFt'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TideStateImplToJson(_$TideStateImpl instance) =>
    <String, dynamic>{
      'phase': _$TidePhaseEnumMap[instance.phase]!,
      'toNextChange': instance.toNextChange.inMicroseconds,
      'amplitudeFt': instance.amplitudeFt,
    };

const _$TidePhaseEnumMap = {
  TidePhase.rising: 'rising',
  TidePhase.falling: 'falling',
  TidePhase.slackHigh: 'slackHigh',
  TidePhase.slackLow: 'slackLow',
};

_$CurrentVectorImpl _$$CurrentVectorImplFromJson(Map<String, dynamic> json) =>
    _$CurrentVectorImpl(
      speedKnots: (json['speedKnots'] as num).toDouble(),
      directionDegrees: (json['directionDegrees'] as num).toDouble(),
    );

Map<String, dynamic> _$$CurrentVectorImplToJson(_$CurrentVectorImpl instance) =>
    <String, dynamic>{
      'speedKnots': instance.speedKnots,
      'directionDegrees': instance.directionDegrees,
    };

_$WindVectorImpl _$$WindVectorImplFromJson(Map<String, dynamic> json) =>
    _$WindVectorImpl(
      speedKnots: (json['speedKnots'] as num).toDouble(),
      directionDegrees: (json['directionDegrees'] as num).toDouble(),
      gustsKnots: (json['gustsKnots'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WindVectorImplToJson(_$WindVectorImpl instance) =>
    <String, dynamic>{
      'speedKnots': instance.speedKnots,
      'directionDegrees': instance.directionDegrees,
      'gustsKnots': instance.gustsKnots,
    };

_$WaveStateImpl _$$WaveStateImplFromJson(Map<String, dynamic> json) =>
    _$WaveStateImpl(
      significantHeightFt: (json['significantHeightFt'] as num).toDouble(),
      dominantPeriodSec: (json['dominantPeriodSec'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WaveStateImplToJson(_$WaveStateImpl instance) =>
    <String, dynamic>{
      'significantHeightFt': instance.significantHeightFt,
      'dominantPeriodSec': instance.dominantPeriodSec,
    };

_$SolunarWindowImpl _$$SolunarWindowImplFromJson(Map<String, dynamic> json) =>
    _$SolunarWindowImpl(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      strength: $enumDecode(_$SolunarStrengthEnumMap, json['strength']),
    );

Map<String, dynamic> _$$SolunarWindowImplToJson(_$SolunarWindowImpl instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'strength': _$SolunarStrengthEnumMap[instance.strength]!,
    };

const _$SolunarStrengthEnumMap = {
  SolunarStrength.major: 'major',
  SolunarStrength.minor: 'minor',
};

_$SolunarStateImpl _$$SolunarStateImplFromJson(Map<String, dynamic> json) =>
    _$SolunarStateImpl(
      sunAltitudeDegrees: (json['sunAltitudeDegrees'] as num).toDouble(),
      sunAzimuthDegrees: (json['sunAzimuthDegrees'] as num).toDouble(),
      moonPhase: $enumDecode(_$MoonPhaseEnumMap, json['moonPhase']),
      moonIlluminationFraction:
          (json['moonIlluminationFraction'] as num).toDouble(),
      majorWindow: json['majorWindow'] == null
          ? null
          : SolunarWindow.fromJson(json['majorWindow'] as Map<String, dynamic>),
      minorWindow: json['minorWindow'] == null
          ? null
          : SolunarWindow.fromJson(json['minorWindow'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SolunarStateImplToJson(_$SolunarStateImpl instance) =>
    <String, dynamic>{
      'sunAltitudeDegrees': instance.sunAltitudeDegrees,
      'sunAzimuthDegrees': instance.sunAzimuthDegrees,
      'moonPhase': _$MoonPhaseEnumMap[instance.moonPhase]!,
      'moonIlluminationFraction': instance.moonIlluminationFraction,
      'majorWindow': instance.majorWindow?.toJson(),
      'minorWindow': instance.minorWindow?.toJson(),
    };

const _$MoonPhaseEnumMap = {
  MoonPhase.newMoon: 'newMoon',
  MoonPhase.waxingCrescent: 'waxingCrescent',
  MoonPhase.firstQuarter: 'firstQuarter',
  MoonPhase.waxingGibbous: 'waxingGibbous',
  MoonPhase.fullMoon: 'fullMoon',
  MoonPhase.waningGibbous: 'waningGibbous',
  MoonPhase.lastQuarter: 'lastQuarter',
  MoonPhase.waningCrescent: 'waningCrescent',
};

_$NamedFeatureImpl _$$NamedFeatureImplFromJson(Map<String, dynamic> json) =>
    _$NamedFeatureImpl(
      name: json['name'] as String,
      location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
      distanceM: (json['distanceM'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$NamedFeatureImplToJson(_$NamedFeatureImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location.toJson(),
      'distanceM': instance.distanceM,
    };

_$StructureInfoImpl _$$StructureInfoImplFromJson(Map<String, dynamic> json) =>
    _$StructureInfoImpl(
      type: $enumDecode(_$StructureTypeEnumMap, json['type']),
      nearbyFeatures: (json['nearbyFeatures'] as List<dynamic>?)
              ?.map((e) => NamedFeature.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NamedFeature>[],
      distanceToContourTransitionM:
          (json['distanceToContourTransitionM'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$StructureInfoImplToJson(_$StructureInfoImpl instance) =>
    <String, dynamic>{
      'type': _$StructureTypeEnumMap[instance.type]!,
      'nearbyFeatures': instance.nearbyFeatures.map((e) => e.toJson()).toList(),
      'distanceToContourTransitionM': instance.distanceToContourTransitionM,
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

_$BarometricStateImpl _$$BarometricStateImplFromJson(
        Map<String, dynamic> json) =>
    _$BarometricStateImpl(
      pressureMillibars: (json['pressureMillibars'] as num).toDouble(),
      trend: $enumDecode(_$BarometricTrendEnumMap, json['trend']),
      rateOfChangeMillibarsPerHour:
          (json['rateOfChangeMillibarsPerHour'] as num).toDouble(),
    );

Map<String, dynamic> _$$BarometricStateImplToJson(
        _$BarometricStateImpl instance) =>
    <String, dynamic>{
      'pressureMillibars': instance.pressureMillibars,
      'trend': _$BarometricTrendEnumMap[instance.trend]!,
      'rateOfChangeMillibarsPerHour': instance.rateOfChangeMillibarsPerHour,
    };

const _$BarometricTrendEnumMap = {
  BarometricTrend.rising: 'rising',
  BarometricTrend.falling: 'falling',
  BarometricTrend.stable: 'stable',
};

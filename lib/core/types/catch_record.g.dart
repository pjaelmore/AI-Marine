// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catch_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConditionSnapshotImpl _$$ConditionSnapshotImplFromJson(
        Map<String, dynamic> json) =>
    _$ConditionSnapshotImpl(
      waterTempF: (json['waterTempF'] as num?)?.toDouble(),
      depthFt: (json['depthFt'] as num?)?.toDouble(),
      tideState: json['tideState'] == null
          ? null
          : TideState.fromJson(json['tideState'] as Map<String, dynamic>),
      solunarState: json['solunarState'] == null
          ? null
          : SolunarState.fromJson(json['solunarState'] as Map<String, dynamic>),
      wind: json['wind'] == null
          ? null
          : WindVector.fromJson(json['wind'] as Map<String, dynamic>),
      waves: json['waves'] == null
          ? null
          : WaveState.fromJson(json['waves'] as Map<String, dynamic>),
      barometric: json['barometric'] == null
          ? null
          : BarometricState.fromJson(
              json['barometric'] as Map<String, dynamic>),
      moonPhase: $enumDecodeNullable(_$MoonPhaseEnumMap, json['moonPhase']),
      weatherSummary: json['weatherSummary'] as String?,
    );

Map<String, dynamic> _$$ConditionSnapshotImplToJson(
        _$ConditionSnapshotImpl instance) =>
    <String, dynamic>{
      'waterTempF': instance.waterTempF,
      'depthFt': instance.depthFt,
      'tideState': instance.tideState?.toJson(),
      'solunarState': instance.solunarState?.toJson(),
      'wind': instance.wind?.toJson(),
      'waves': instance.waves?.toJson(),
      'barometric': instance.barometric?.toJson(),
      'moonPhase': _$MoonPhaseEnumMap[instance.moonPhase],
      'weatherSummary': instance.weatherSummary,
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

_$CatchRecordImpl _$$CatchRecordImplFromJson(Map<String, dynamic> json) =>
    _$CatchRecordImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
      locationSource:
          $enumDecode(_$LocationSourceEnumMap, json['locationSource']),
      speciesId: json['speciesId'] as String,
      conditions: ConditionSnapshot.fromJson(
          json['conditions'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      sizeClassId: json['sizeClassId'] as String?,
      lengthInches: (json['lengthInches'] as num?)?.toDouble(),
      weightPounds: (json['weightPounds'] as num?)?.toDouble(),
      baitOrLure: json['baitOrLure'] as String?,
      released: json['released'] as bool?,
      notes: json['notes'] as String?,
      photoLocalPath: json['photoLocalPath'] as String?,
      recommendationPinId: json['recommendationPinId'] as String?,
      engineScoreAtCatch: (json['engineScoreAtCatch'] as num?)?.toDouble(),
      engineReasoningAtCatch: json['engineReasoningAtCatch'] == null
          ? null
          : ReasoningBreakdown.fromJson(
              json['engineReasoningAtCatch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CatchRecordImplToJson(_$CatchRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
      'location': instance.location.toJson(),
      'locationSource': _$LocationSourceEnumMap[instance.locationSource]!,
      'speciesId': instance.speciesId,
      'conditions': instance.conditions.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'sizeClassId': instance.sizeClassId,
      'lengthInches': instance.lengthInches,
      'weightPounds': instance.weightPounds,
      'baitOrLure': instance.baitOrLure,
      'released': instance.released,
      'notes': instance.notes,
      'photoLocalPath': instance.photoLocalPath,
      'recommendationPinId': instance.recommendationPinId,
      'engineScoreAtCatch': instance.engineScoreAtCatch,
      'engineReasoningAtCatch': instance.engineReasoningAtCatch?.toJson(),
    };

const _$LocationSourceEnumMap = {
  LocationSource.phoneGps: 'phoneGps',
  LocationSource.nmea2000: 'nmea2000',
  LocationSource.manual: 'manual',
  LocationSource.lastKnown: 'lastKnown',
};

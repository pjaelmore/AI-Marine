// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpeciesRecordImpl _$$SpeciesRecordImplFromJson(Map<String, dynamic> json) =>
    _$SpeciesRecordImpl(
      id: json['id'] as String,
      scientificName: json['scientificName'] as String,
      commonNames: (json['commonNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      schemaVersion: json['schemaVersion'] as String,
      curationVersion: json['curationVersion'] as String,
      sizeClasses: (json['sizeClasses'] as List<dynamic>)
          .map((e) => SizeClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      migrationModel: MigrationModel.fromJson(
          json['migrationModel'] as Map<String, dynamic>),
      conditionProfile: ConditionProfile.fromJson(
          json['conditionProfile'] as Map<String, dynamic>),
      regulatoryProfile: RegulatoryProfile.fromJson(
          json['regulatoryProfile'] as Map<String, dynamic>),
      confidence: $enumDecode(_$ConfidenceLevelEnumMap, json['confidence']),
      dataProvenance: (json['dataProvenance'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
    );

Map<String, dynamic> _$$SpeciesRecordImplToJson(_$SpeciesRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scientificName': instance.scientificName,
      'commonNames': instance.commonNames,
      'schemaVersion': instance.schemaVersion,
      'curationVersion': instance.curationVersion,
      'sizeClasses': instance.sizeClasses.map((e) => e.toJson()).toList(),
      'migrationModel': instance.migrationModel.toJson(),
      'conditionProfile': instance.conditionProfile.toJson(),
      'regulatoryProfile': instance.regulatoryProfile.toJson(),
      'confidence': _$ConfidenceLevelEnumMap[instance.confidence]!,
      'dataProvenance': instance.dataProvenance,
    };

const _$ConfidenceLevelEnumMap = {
  ConfidenceLevel.exploratory: 'exploratory',
  ConfidenceLevel.calibrated: 'calibrated',
  ConfidenceLevel.validated: 'validated',
};

_$SizeClassImpl _$$SizeClassImplFromJson(Map<String, dynamic> json) =>
    _$SizeClassImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      minLengthInches: (json['minLengthInches'] as num?)?.toDouble(),
      maxLengthInches: (json['maxLengthInches'] as num?)?.toDouble(),
      overrideProfile: json['overrideProfile'] == null
          ? null
          : ConditionProfile.fromJson(
              json['overrideProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SizeClassImplToJson(_$SizeClassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'minLengthInches': instance.minLengthInches,
      'maxLengthInches': instance.maxLengthInches,
      'overrideProfile': instance.overrideProfile?.toJson(),
    };

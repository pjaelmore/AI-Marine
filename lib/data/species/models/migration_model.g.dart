// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MigrationModelImpl _$$MigrationModelImplFromJson(Map<String, dynamic> json) =>
    _$MigrationModelImpl(
      spatialRange:
          GeoPolygon.fromJson(json['spatialRange'] as Map<String, dynamic>),
      populations: (json['populations'] as List<dynamic>?)
              ?.map((e) => Population.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Population>[],
      regionalCurves: (json['regionalCurves'] as List<dynamic>?)
              ?.map((e) =>
                  RegionalPresenceCurve.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RegionalPresenceCurve>[],
      corridors: (json['corridors'] as List<dynamic>?)
              ?.map(
                  (e) => MigrationCorridor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MigrationCorridor>[],
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map((e) => TriggerRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TriggerRule>[],
    );

Map<String, dynamic> _$$MigrationModelImplToJson(
        _$MigrationModelImpl instance) =>
    <String, dynamic>{
      'spatialRange': instance.spatialRange.toJson(),
      'populations': instance.populations.map((e) => e.toJson()).toList(),
      'regionalCurves': instance.regionalCurves.map((e) => e.toJson()).toList(),
      'corridors': instance.corridors.map((e) => e.toJson()).toList(),
      'triggers': instance.triggers.map((e) => e.toJson()).toList(),
    };

_$PopulationImpl _$$PopulationImplFromJson(Map<String, dynamic> json) =>
    _$PopulationImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String,
      regionIds: (json['regionIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$PopulationImplToJson(_$PopulationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'description': instance.description,
      'regionIds': instance.regionIds,
    };

_$RegionalPresenceCurveImpl _$$RegionalPresenceCurveImplFromJson(
        Map<String, dynamic> json) =>
    _$RegionalPresenceCurveImpl(
      regionId: json['regionId'] as String,
      regionPolygon:
          GeoPolygon.fromJson(json['regionPolygon'] as Map<String, dynamic>),
      weeklyValues: (json['weeklyValues'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$RegionalPresenceCurveImplToJson(
        _$RegionalPresenceCurveImpl instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'regionPolygon': instance.regionPolygon.toJson(),
      'weeklyValues': instance.weeklyValues,
    };

_$MigrationCorridorImpl _$$MigrationCorridorImplFromJson(
        Map<String, dynamic> json) =>
    _$MigrationCorridorImpl(
      id: json['id'] as String,
      path: (json['path'] as List<dynamic>)
          .map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
      widthNm: (json['widthNm'] as num).toDouble(),
      activeWeekStart: (json['activeWeekStart'] as num).toInt(),
      activeWeekEnd: (json['activeWeekEnd'] as num).toInt(),
    );

Map<String, dynamic> _$$MigrationCorridorImplToJson(
        _$MigrationCorridorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path.map((e) => e.toJson()).toList(),
      'widthNm': instance.widthNm,
      'activeWeekStart': instance.activeWeekStart,
      'activeWeekEnd': instance.activeWeekEnd,
    };

_$TriggerRuleImpl _$$TriggerRuleImplFromJson(Map<String, dynamic> json) =>
    _$TriggerRuleImpl(
      id: json['id'] as String,
      kind: $enumDecode(_$TriggerKindEnumMap, json['kind']),
      parameters: json['parameters'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$$TriggerRuleImplToJson(_$TriggerRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$TriggerKindEnumMap[instance.kind]!,
      'parameters': instance.parameters,
    };

const _$TriggerKindEnumMap = {
  TriggerKind.sstAnomalyShift: 'sstAnomalyShift',
  TriggerKind.photoperiodThreshold: 'photoperiodThreshold',
  TriggerKind.baitfishPresenceModifier: 'baitfishPresenceModifier',
  TriggerKind.custom: 'custom',
};

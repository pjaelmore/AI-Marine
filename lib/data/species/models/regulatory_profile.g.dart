// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regulatory_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegulatoryProfileImpl _$$RegulatoryProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$RegulatoryProfileImpl(
      rules: (json['rules'] as List<dynamic>?)
              ?.map((e) => RegulatoryRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RegulatoryRule>[],
      restrictedZones: (json['restrictedZones'] as List<dynamic>?)
              ?.map((e) => RestrictedZone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RestrictedZone>[],
      permitRequirements: (json['permitRequirements'] as List<dynamic>?)
              ?.map(
                  (e) => PermitRequirement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PermitRequirement>[],
      gearRestrictions: (json['gearRestrictions'] as List<dynamic>?)
              ?.map((e) => GearRestriction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GearRestriction>[],
    );

Map<String, dynamic> _$$RegulatoryProfileImplToJson(
        _$RegulatoryProfileImpl instance) =>
    <String, dynamic>{
      'rules': instance.rules.map((e) => e.toJson()).toList(),
      'restrictedZones':
          instance.restrictedZones.map((e) => e.toJson()).toList(),
      'permitRequirements':
          instance.permitRequirements.map((e) => e.toJson()).toList(),
      'gearRestrictions':
          instance.gearRestrictions.map((e) => e.toJson()).toList(),
    };

_$RegulatoryRuleImpl _$$RegulatoryRuleImplFromJson(Map<String, dynamic> json) =>
    _$RegulatoryRuleImpl(
      id: json['id'] as String,
      jurisdictionId: json['jurisdictionId'] as String,
      scope: $enumDecode(_$RuleScopeEnumMap, json['scope']),
      parameters: json['parameters'] as Map<String, dynamic>,
      effectiveFrom: DateTime.parse(json['effectiveFrom'] as String),
      source: SourceReference.fromJson(json['source'] as Map<String, dynamic>),
      subRegionId: json['subRegionId'] as String?,
      effectiveTo: json['effectiveTo'] == null
          ? null
          : DateTime.parse(json['effectiveTo'] as String),
    );

Map<String, dynamic> _$$RegulatoryRuleImplToJson(
        _$RegulatoryRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jurisdictionId': instance.jurisdictionId,
      'scope': _$RuleScopeEnumMap[instance.scope]!,
      'parameters': instance.parameters,
      'effectiveFrom': instance.effectiveFrom.toIso8601String(),
      'source': instance.source.toJson(),
      'subRegionId': instance.subRegionId,
      'effectiveTo': instance.effectiveTo?.toIso8601String(),
    };

const _$RuleScopeEnumMap = {
  RuleScope.closedSeason: 'closedSeason',
  RuleScope.bagLimit: 'bagLimit',
  RuleScope.vesselLimit: 'vesselLimit',
  RuleScope.slotLimit: 'slotLimit',
  RuleScope.minSize: 'minSize',
  RuleScope.maxSize: 'maxSize',
  RuleScope.catchAndReleaseOnly: 'catchAndReleaseOnly',
  RuleScope.permitRequired: 'permitRequired',
  RuleScope.gearRestriction: 'gearRestriction',
};

_$RestrictedZoneImpl _$$RestrictedZoneImplFromJson(Map<String, dynamic> json) =>
    _$RestrictedZoneImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      polygon: GeoPolygon.fromJson(json['polygon'] as Map<String, dynamic>),
      kind: $enumDecode(_$RestrictionKindEnumMap, json['kind']),
      source: SourceReference.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RestrictedZoneImplToJson(
        _$RestrictedZoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'polygon': instance.polygon.toJson(),
      'kind': _$RestrictionKindEnumMap[instance.kind]!,
      'source': instance.source.toJson(),
    };

const _$RestrictionKindEnumMap = {
  RestrictionKind.mpa: 'mpa',
  RestrictionKind.spawningClosure: 'spawningClosure',
  RestrictionKind.speciesSpecificClosure: 'speciesSpecificClosure',
  RestrictionKind.militaryZone: 'militaryZone',
};

_$PermitRequirementImpl _$$PermitRequirementImplFromJson(
        Map<String, dynamic> json) =>
    _$PermitRequirementImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      issuingAuthority: json['issuingAuthority'] as String,
      infoUrl: json['infoUrl'] as String?,
    );

Map<String, dynamic> _$$PermitRequirementImplToJson(
        _$PermitRequirementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'issuingAuthority': instance.issuingAuthority,
      'infoUrl': instance.infoUrl,
    };

_$GearRestrictionImpl _$$GearRestrictionImplFromJson(
        Map<String, dynamic> json) =>
    _$GearRestrictionImpl(
      description: json['description'] as String,
      jurisdictionId: json['jurisdictionId'] as String?,
    );

Map<String, dynamic> _$$GearRestrictionImplToJson(
        _$GearRestrictionImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'jurisdictionId': instance.jurisdictionId,
    };

_$SourceReferenceImpl _$$SourceReferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$SourceReferenceImpl(
      authority: json['authority'] as String,
      documentTitle: json['documentTitle'] as String,
      lastVerifiedAt: DateTime.parse(json['lastVerifiedAt'] as String),
      url: json['url'] as String?,
      documentVersion: json['documentVersion'] as String?,
    );

Map<String, dynamic> _$$SourceReferenceImplToJson(
        _$SourceReferenceImpl instance) =>
    <String, dynamic>{
      'authority': instance.authority,
      'documentTitle': instance.documentTitle,
      'lastVerifiedAt': instance.lastVerifiedAt.toIso8601String(),
      'url': instance.url,
      'documentVersion': instance.documentVersion,
    };

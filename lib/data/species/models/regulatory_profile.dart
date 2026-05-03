import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/types/lat_lng.dart';

part 'regulatory_profile.freezed.dart';
part 'regulatory_profile.g.dart';

/// All regulatory state for a species: jurisdictional rules, restricted
/// zones, permits, gear restrictions. Mirrors TDD §3.3.4.
///
/// Curated annually; v1 reflects 2025 ASMFC and state regulations as of the
/// TDD drafting date (TDD §3.3 closing note). Updates ship as new species
/// data files without code changes.
@freezed
class RegulatoryProfile with _$RegulatoryProfile {
  const factory RegulatoryProfile({
    @Default(<RegulatoryRule>[]) List<RegulatoryRule> rules,
    @Default(<RestrictedZone>[]) List<RestrictedZone> restrictedZones,
    @Default(<PermitRequirement>[]) List<PermitRequirement> permitRequirements,
    @Default(<GearRestriction>[]) List<GearRestriction> gearRestrictions,
  }) = _RegulatoryProfile;

  factory RegulatoryProfile.fromJson(Map<String, dynamic> json) =>
      _$RegulatoryProfileFromJson(json);
}

/// A single jurisdictional rule (slot, bag, season, etc.). [parameters] is
/// open-shape so a closed-season rule can carry start/end dates while a
/// slot rule carries min/max inches in the same Map.
@freezed
class RegulatoryRule with _$RegulatoryRule {
  const factory RegulatoryRule({
    required String id,
    required String jurisdictionId,
    required RuleScope scope,
    required Map<String, dynamic> parameters,
    required DateTime effectiveFrom,
    required SourceReference source,
    String? subRegionId,
    DateTime? effectiveTo,
  }) = _RegulatoryRule;

  factory RegulatoryRule.fromJson(Map<String, dynamic> json) =>
      _$RegulatoryRuleFromJson(json);
}

enum RuleScope {
  closedSeason,
  bagLimit,
  vesselLimit,
  slotLimit,
  minSize,
  maxSize,
  catchAndReleaseOnly,
  permitRequired,
  gearRestriction,
}

/// A spatial closure or restriction — marine protected area, spawning
/// closure, military zone, etc.
@freezed
class RestrictedZone with _$RestrictedZone {
  const factory RestrictedZone({
    required String id,
    required String name,
    required GeoPolygon polygon,
    required RestrictionKind kind,
    required SourceReference source,
  }) = _RestrictedZone;

  factory RestrictedZone.fromJson(Map<String, dynamic> json) =>
      _$RestrictedZoneFromJson(json);
}

enum RestrictionKind {
  mpa,
  spawningClosure,
  speciesSpecificClosure,
  militaryZone,
}

@freezed
class PermitRequirement with _$PermitRequirement {
  const factory PermitRequirement({
    required String id,
    required String displayName,
    required String issuingAuthority,
    String? infoUrl,
  }) = _PermitRequirement;

  factory PermitRequirement.fromJson(Map<String, dynamic> json) =>
      _$PermitRequirementFromJson(json);
}

@freezed
class GearRestriction with _$GearRestriction {
  const factory GearRestriction({
    required String description,
    String? jurisdictionId,
  }) = _GearRestriction;

  factory GearRestriction.fromJson(Map<String, dynamic> json) =>
      _$GearRestrictionFromJson(json);
}

/// Provenance for a regulatory rule or restriction — ASMFC document,
/// state-DEP notice, etc. Recorded so the UI can surface "last verified"
/// freshness and link to the source.
@freezed
class SourceReference with _$SourceReference {
  const factory SourceReference({
    required String authority,
    required String documentTitle,
    required DateTime lastVerifiedAt,
    String? url,
    String? documentVersion,
  }) = _SourceReference;

  factory SourceReference.fromJson(Map<String, dynamic> json) =>
      _$SourceReferenceFromJson(json);
}

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:flutter_test/flutter_test.dart';

SourceReference _asmfcSource() => SourceReference(
      authority: 'ASMFC',
      documentTitle: 'Atlantic Striped Bass Interstate FMP, Amendment 7',
      lastVerifiedAt: DateTime.utc(2026, 4, 15),
      url: 'https://www.asmfc.org/uploads/file/abc123/striper_amendment_7.pdf',
      documentVersion: 'amendment-7-rev-2025',
    );

const _exclusionPolygon = GeoPolygon(
  rings: [
    [
      LatLng(latitude: 41.0, longitude: -70.5),
      LatLng(latitude: 41.5, longitude: -70.5),
      LatLng(latitude: 41.5, longitude: -70.0),
      LatLng(latitude: 41.0, longitude: -70.0),
    ],
  ],
);

void main() {
  group('SourceReference JSON round-trip', () {
    test('preserves authority, version, URL, and lastVerifiedAt', () {
      final original = _asmfcSource();
      final restored = SourceReference.fromJson(original.toJson());
      expect(restored, original);
    });
  });

  group('RegulatoryRule JSON round-trip', () {
    test('preserves open parameters map and effectiveTo when present', () {
      final original = RegulatoryRule(
        id: 'ma_state_slot_2025',
        jurisdictionId: 'ma',
        scope: RuleScope.slotLimit,
        parameters: const {'minInches': 28.0, 'maxInches': 31.0},
        effectiveFrom: DateTime.utc(2025, 1, 1),
        effectiveTo: DateTime.utc(2025, 12, 31),
        source: _asmfcSource(),
      );
      expect(RegulatoryRule.fromJson(original.toJson()), original);
    });

    test('handles null subRegionId and effectiveTo', () {
      final original = RegulatoryRule(
        id: 'asmfc_coastwide',
        jurisdictionId: 'asmfc',
        scope: RuleScope.bagLimit,
        parameters: const {'perAngler': 1},
        effectiveFrom: DateTime.utc(2025, 1, 1),
        source: _asmfcSource(),
      );
      final restored = RegulatoryRule.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.subRegionId, isNull);
      expect(restored.effectiveTo, isNull);
    });
  });

  group('RestrictedZone JSON round-trip', () {
    test('preserves polygon and source provenance', () {
      final original = RestrictedZone(
        id: 'spawning_block_island',
        name: 'Spawning closure — Block Island Sound',
        polygon: _exclusionPolygon,
        kind: RestrictionKind.spawningClosure,
        source: _asmfcSource(),
      );
      expect(RestrictedZone.fromJson(original.toJson()), original);
    });
  });

  group('PermitRequirement JSON round-trip', () {
    test('preserves all fields including optional URL', () {
      const original = PermitRequirement(
        id: 'ma_saltwater_2025',
        displayName: 'MA Saltwater Recreational Fishing Permit',
        issuingAuthority: 'MA Division of Marine Fisheries',
        infoUrl: 'https://www.mass.gov/saltwater-fishing-permit',
      );
      expect(PermitRequirement.fromJson(original.toJson()), original);
    });
  });

  group('GearRestriction JSON round-trip', () {
    test('preserves description and optional jurisdiction scope', () {
      const original = GearRestriction(
        description: 'Circle hooks required when fishing with bait.',
        jurisdictionId: 'asmfc',
      );
      expect(GearRestriction.fromJson(original.toJson()), original);
    });
  });

  group('RegulatoryProfile JSON round-trip', () {
    test('preserves nested rules, zones, permits, and restrictions', () {
      final original = RegulatoryProfile(
        rules: [
          RegulatoryRule(
            id: 'ma_slot',
            jurisdictionId: 'ma',
            scope: RuleScope.slotLimit,
            parameters: const {'minInches': 28.0, 'maxInches': 31.0},
            effectiveFrom: DateTime.utc(2025, 1, 1),
            source: _asmfcSource(),
          ),
        ],
        restrictedZones: [
          RestrictedZone(
            id: 'block_island_spawning',
            name: 'Block Island Spawning Closure',
            polygon: _exclusionPolygon,
            kind: RestrictionKind.spawningClosure,
            source: _asmfcSource(),
          ),
        ],
        permitRequirements: const [
          PermitRequirement(
            id: 'ma_perm',
            displayName: 'MA Saltwater Permit',
            issuingAuthority: 'MA DMF',
          ),
        ],
        gearRestrictions: const [
          GearRestriction(description: 'Circle hooks required with bait.'),
        ],
      );
      final restored = RegulatoryProfile.fromJson(original.toJson());
      expect(restored, original);
    });

    test('default child collections are empty', () {
      const profile = RegulatoryProfile();
      expect(profile.rules, isEmpty);
      expect(profile.restrictedZones, isEmpty);
      expect(profile.permitRequirements, isEmpty);
      expect(profile.gearRestrictions, isEmpty);
    });
  });
}

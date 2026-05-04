import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/services/calculator/contributors/structure_proximity_contributor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';

/// Snook-flavored structure preferences: ledges, channel edges, and
/// weed lines (mangrove proxies) carry meaningful weight.
const _snookStructure = [
  StructurePreference(type: StructureType.ledge, weight: 0.7),
  StructurePreference(type: StructureType.channelEdge, weight: 0.6),
  StructurePreference(type: StructureType.weedLine, weight: 0.8),
];

StructureInfo _info(StructureType type) => StructureInfo(type: type);

void main() {
  group('evaluateStructureProximityContributor — envelope', () {
    test('returns ContributorApplication with name and rangeMax', () {
      final r = evaluateStructureProximityContributor(
        structure: _info(StructureType.weedLine),
        preferences: _snookStructure,
      );
      expect(r.name, 'structure_proximity');
      expect(r.rangeMax, 1.0);
    });
  });

  group('evaluateStructureProximityContributor — type matching', () {
    test('matching type contributes the species weight', () {
      expect(
        evaluateStructureProximityContributor(
          structure: _info(StructureType.weedLine),
          preferences: _snookStructure,
        ).value,
        0.8,
      );
    });

    test('different matching type picks up its own weight', () {
      expect(
        evaluateStructureProximityContributor(
          structure: _info(StructureType.ledge),
          preferences: _snookStructure,
        ).value,
        0.7,
      );
    });

    test('non-matching type contributes 0 with descriptive reason', () {
      final r = evaluateStructureProximityContributor(
        structure: _info(StructureType.sandFlat),
        preferences: _snookStructure,
      );
      expect(r.value, 0);
      expect(r.description, contains('No species preference'));
      expect(r.description, contains('sand flat'));
    });

    test('empty preferences list contributes 0', () {
      expect(
        evaluateStructureProximityContributor(
          structure: _info(StructureType.reef),
          preferences: const [],
        ).value,
        0,
      );
    });
  });

  group('evaluateStructureProximityContributor — unknown type', () {
    test('StructureType.unknown contributes 0 with "unknown" description', () {
      final r = evaluateStructureProximityContributor(
        structure: _info(StructureType.unknown),
        preferences: _snookStructure,
      );
      expect(r.value, 0);
      expect(r.description, contains('unknown'));
    });
  });

  group('evaluateStructureProximityContributor — clamping', () {
    test('species weight > rangeMax is clamped to 1.0', () {
      const overzealous = [
        StructurePreference(type: StructureType.reef, weight: 5.0),
      ];
      expect(
        evaluateStructureProximityContributor(
          structure: _info(StructureType.reef),
          preferences: overzealous,
        ).value,
        1.0,
      );
    });

    test('negative species weight is clamped to 0', () {
      const malformed = [
        StructurePreference(type: StructureType.reef, weight: -0.5),
      ];
      expect(
        evaluateStructureProximityContributor(
          structure: _info(StructureType.reef),
          preferences: malformed,
        ).value,
        0,
      );
    });
  });

  group('evaluateStructureProximityContributor — first-match semantics', () {
    test('duplicate preferences for one type → first match wins', () {
      // Defensive against malformed species data with duplicates.
      const dupes = [
        StructurePreference(type: StructureType.reef, weight: 0.3),
        StructurePreference(type: StructureType.reef, weight: 0.9),
      ];
      expect(
        evaluateStructureProximityContributor(
          structure: _info(StructureType.reef),
          preferences: dupes,
        ).value,
        0.3,
      );
    });
  });
}

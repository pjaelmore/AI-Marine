import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:ai_marine_engine/data/species/models/species_record.dart';
import 'package:flutter_test/flutter_test.dart';

const _massBay = GeoPolygon(
  rings: [
    [
      LatLng(latitude: 42.0, longitude: -71.0),
      LatLng(latitude: 42.0, longitude: -70.0),
      LatLng(latitude: 43.0, longitude: -70.0),
      LatLng(latitude: 43.0, longitude: -71.0),
    ],
  ],
);

ConditionProfile _baseProfile() => const ConditionProfile(
      optimalTemp: TemperatureRange(minF: 58, maxF: 66, idealF: 62),
      toleratedTemp: TemperatureRange(minF: 50, maxF: 72, idealF: 62),
      depthPreference: DepthPreference(minFt: 5, maxFt: 50, idealFt: 20),
      tidePreference: TidePreference(
        phaseWeights: {TidePhase.rising: 0.7, TidePhase.falling: 0.85},
      ),
      solunarSensitivity: SolunarSensitivity.high,
      lunarSensitivity: LunarSensitivity.medium,
      weatherSensitivity: WeatherSensitivity(
        risingPressureFactor: 0.9,
        fallingPressureFactor: 1.05,
        frontalPassageFactor: 1.1,
        cloudCoverPreference: 0.6,
      ),
      currentPreference:
          CurrentPreference(minKnots: 0.5, maxKnots: 3.0, idealKnots: 1.5),
    );

void main() {
  group('SizeClass JSON round-trip', () {
    test('preserves overrideProfile when present', () {
      final original = SizeClass(
        id: 'trophy',
        displayName: 'Trophy (40+ inches)',
        minLengthInches: 40,
        overrideProfile: _baseProfile().copyWith(
          optimalTemp: const TemperatureRange(minF: 55, maxF: 64, idealF: 60),
        ),
      );
      final restored = SizeClass.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.overrideProfile?.optimalTemp.idealF, 60);
    });

    test('handles all-null optional length bounds and override', () {
      const original = SizeClass(
        id: 'any',
        displayName: 'Any size',
      );
      final restored = SizeClass.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.minLengthInches, isNull);
      expect(restored.maxLengthInches, isNull);
      expect(restored.overrideProfile, isNull);
    });
  });

  group('SpeciesRecord JSON round-trip', () {
    test('preserves full record across the entire §3.3 schema', () {
      final record = SpeciesRecord(
        id: 'striped_bass',
        scientificName: 'Morone saxatilis',
        commonNames: const ['striped bass', 'striper', 'rockfish'],
        schemaVersion: '1.0.0',
        curationVersion: '2025.4',
        sizeClasses: [
          const SizeClass(
            id: 'schoolie',
            displayName: 'Schoolie (20–28 in)',
            minLengthInches: 20,
            maxLengthInches: 28,
          ),
          SizeClass(
            id: 'slot',
            displayName: 'Slot (28–31 in)',
            minLengthInches: 28,
            maxLengthInches: 31,
            overrideProfile: _baseProfile(),
          ),
        ],
        migrationModel: const MigrationModel(
          spatialRange: _massBay,
          populations: [
            Population(
              id: 'chesapeake',
              displayName: 'Chesapeake migrants',
              description: 'Spring run from Chesapeake spawning grounds.',
            ),
          ],
        ),
        conditionProfile: _baseProfile(),
        regulatoryProfile: RegulatoryProfile(
          rules: [
            RegulatoryRule(
              id: 'asmfc_coastwide_slot',
              jurisdictionId: 'asmfc',
              scope: RuleScope.slotLimit,
              parameters: const {'minInches': 28.0, 'maxInches': 31.0},
              effectiveFrom: DateTime.utc(2025, 1, 1),
              source: SourceReference(
                authority: 'ASMFC',
                documentTitle: 'Atlantic Striped Bass FMP Amendment 7',
                lastVerifiedAt: DateTime.utc(2026, 4, 15),
              ),
            ),
          ],
        ),
        confidence: ConfidenceLevel.calibrated,
      );

      final restored = SpeciesRecord.fromJson(record.toJson());
      expect(restored, record);
    });
  });
}

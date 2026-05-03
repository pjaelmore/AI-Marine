import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:flutter_test/flutter_test.dart';

ConditionProfile _striperProfile() => const ConditionProfile(
      optimalTemp: TemperatureRange(minF: 58, maxF: 66, idealF: 62),
      toleratedTemp: TemperatureRange(minF: 50, maxF: 72, idealF: 62),
      depthPreference: DepthPreference(minFt: 5, maxFt: 50, idealFt: 20),
      structurePreferences: [
        StructurePreference(type: StructureType.channelEdge, weight: 0.9),
        StructurePreference(type: StructureType.dropOff, weight: 0.7),
      ],
      tidePreference: TidePreference(
        phaseWeights: {
          TidePhase.rising: 0.7,
          TidePhase.falling: 0.85,
          TidePhase.slackHigh: 0.4,
          TidePhase.slackLow: 0.4,
        },
        prefersSpringTides: true,
      ),
      solunarSensitivity: SolunarSensitivity.high,
      timeOfDayPreferences: [
        TimeOfDayPreference(startHour: 4, endHour: 8, weight: 1.0),
        TimeOfDayPreference(startHour: 18, endHour: 22, weight: 0.95),
      ],
      lunarSensitivity: LunarSensitivity.medium,
      weatherSensitivity: WeatherSensitivity(
        risingPressureFactor: 0.9,
        fallingPressureFactor: 1.05,
        frontalPassageFactor: 1.1,
        cloudCoverPreference: 0.6,
      ),
      currentPreference: CurrentPreference(
        minKnots: 0.5,
        maxKnots: 3.0,
        idealKnots: 1.5,
      ),
      baitAssociations: [
        BaitAssociation(baitfish: 'menhaden', weight: 0.95),
        BaitAssociation(baitfish: 'sand_eel', weight: 0.8),
      ],
    );

void main() {
  group('ConditionProfile JSON round-trip', () {
    test('preserves a striper-shaped profile end to end', () {
      final original = _striperProfile();
      final restored = ConditionProfile.fromJson(original.toJson());
      expect(restored, original);
    });

    test('handles a null optional salinity preference', () {
      final original = _striperProfile();
      expect(original.salinityPreference, isNull);
      final restored = ConditionProfile.fromJson(original.toJson());
      expect(restored.salinityPreference, isNull);
    });

    test('handles a populated salinity preference', () {
      final base = _striperProfile();
      final original = base.copyWith(
        salinityPreference: const SalinityPreference(
          minPpt: 5,
          maxPpt: 35,
          idealPpt: 20,
        ),
      );
      final restored = ConditionProfile.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.salinityPreference?.idealPpt, 20);
    });

    test('default child collections are empty', () {
      const minimal = ConditionProfile(
        optimalTemp: TemperatureRange(minF: 0, maxF: 1, idealF: 0.5),
        toleratedTemp: TemperatureRange(minF: 0, maxF: 1, idealF: 0.5),
        depthPreference: DepthPreference(minFt: 0, maxFt: 1, idealFt: 0.5),
        tidePreference: TidePreference(phaseWeights: {}),
        solunarSensitivity: SolunarSensitivity.none,
        lunarSensitivity: LunarSensitivity.none,
        weatherSensitivity: WeatherSensitivity(
          risingPressureFactor: 1,
          fallingPressureFactor: 1,
          frontalPassageFactor: 1,
          cloudCoverPreference: 0.5,
        ),
        currentPreference:
            CurrentPreference(minKnots: 0, maxKnots: 0, idealKnots: 0),
      );
      expect(minimal.structurePreferences, isEmpty);
      expect(minimal.timeOfDayPreferences, isEmpty);
      expect(minimal.baitAssociations, isEmpty);
    });
  });

  group('TidePreference enum-keyed map', () {
    test('round-trips with TidePhase keys serialised as strings', () {
      const original = TidePreference(
        phaseWeights: {
          TidePhase.rising: 0.7,
          TidePhase.falling: 0.85,
        },
      );
      final json = original.toJson();
      // Confirm the map is keyed by enum *name* in JSON form.
      final phaseWeightsJson = json['phaseWeights'] as Map<String, dynamic>;
      expect(phaseWeightsJson.keys, containsAll(['rising', 'falling']));
      // And that the round-trip restores the enum keys.
      expect(TidePreference.fromJson(json), original);
    });
  });
}

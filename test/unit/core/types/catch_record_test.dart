import 'package:ai_marine_engine/core/types/catch_record.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConditionSnapshot JSON round-trip', () {
    test('preserves a fully-populated snapshot', () {
      final original = ConditionSnapshot(
        waterTempF: 62.3,
        depthFt: 18.5,
        tideState: const TideState(
          phase: TidePhase.falling,
          toNextChange: Duration(hours: 1, minutes: 15),
          amplitudeFt: 4.2,
        ),
        solunarState: SolunarState(
          sunAltitudeDegrees: -3.0,
          sunAzimuthDegrees: 285.0,
          moonPhase: MoonPhase.firstQuarter,
          moonIlluminationFraction: 0.5,
          majorWindow: SolunarWindow(
            start: DateTime.utc(2026, 5, 22, 18, 0),
            end: DateTime.utc(2026, 5, 22, 19, 0),
            strength: SolunarStrength.major,
          ),
        ),
        wind: const WindVector(
          speedKnots: 8.0,
          directionDegrees: 220.0,
          gustsKnots: 12.0,
        ),
        waves: const WaveState(significantHeightFt: 1.5, dominantPeriodSec: 6),
        barometric: const BarometricState(
          pressureMillibars: 1011.5,
          trend: BarometricTrend.falling,
          rateOfChangeMillibarsPerHour: -0.8,
        ),
        moonPhase: MoonPhase.firstQuarter,
        weatherSummary: 'Overcast, 65°F, light SW wind.',
      );
      expect(ConditionSnapshot.fromJson(original.toJson()), original);
    });

    test('handles every field null', () {
      const original = ConditionSnapshot();
      final restored = ConditionSnapshot.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.waterTempF, isNull);
      expect(restored.tideState, isNull);
    });
  });

  group('CatchRecord JSON round-trip', () {
    test('preserves a minimal catch with auto-captured conditions', () {
      final original = CatchRecord(
        id: 'catch-001',
        userId: 'user-paul',
        timestamp: DateTime.utc(2026, 5, 22, 18, 30),
        location: const LatLng(latitude: 42.36, longitude: -70.55),
        locationSource: LocationSource.phoneGps,
        speciesId: 'striped_bass',
        conditions: const ConditionSnapshot(
          waterTempF: 62.0,
          depthFt: 18.0,
        ),
        createdAt: DateTime.utc(2026, 5, 22, 18, 30, 5),
        updatedAt: DateTime.utc(2026, 5, 22, 18, 30, 5),
      );
      final restored = CatchRecord.fromJson(original.toJson());
      expect(restored, original);
    });

    test('preserves a fully-decorated catch with engine score and reasoning',
        () {
      final original = CatchRecord(
        id: 'catch-002',
        userId: 'user-paul',
        timestamp: DateTime.utc(2026, 5, 22, 19, 0),
        location: const LatLng(latitude: 42.36, longitude: -70.55),
        locationSource: LocationSource.nmea2000,
        speciesId: 'striped_bass',
        sizeClassId: 'slot',
        lengthInches: 29.5,
        weightPounds: 11.2,
        baitOrLure: 'live menhaden',
        released: true,
        notes: 'Hooked on the falling tide near the channel edge.',
        photoLocalPath: '/photos/catch-002.jpg',
        recommendationPinId: 'pin-3',
        conditions: const ConditionSnapshot(waterTempF: 62.0, depthFt: 18.0),
        engineScoreAtCatch: 8.4,
        engineReasoningAtCatch: const ReasoningBreakdown(
          baseProbability: 0.7,
          gates: [GateResult(name: 'Migration presence', passed: true)],
          modifiers: [
            ModifierApplication(
              name: 'Tide phase',
              value: 1.1,
              rangeMin: 0.5,
              rangeMax: 1.5,
              description: 'Falling — favoured.',
            ),
          ],
          contributors: [
            ContributorApplication(
              name: 'Personal history',
              value: 0.9,
              rangeMax: 2.0,
              description: 'Two prior catches within 0.25 nm.',
            ),
          ],
          rawScoreBeforeContributors: 7.7,
          additiveTotal: 0.9,
          finalScore: 8.4,
          migrationSummary: 'Spring run, Chesapeake migrants present.',
          suggestedApproach: 'Live eels at the channel edge on the falling.',
        ),
        createdAt: DateTime.utc(2026, 5, 22, 19, 0, 5),
        updatedAt: DateTime.utc(2026, 5, 22, 19, 0, 5),
      );
      final restored = CatchRecord.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.engineScoreAtCatch, 8.4);
      expect(restored.engineReasoningAtCatch?.gates, hasLength(1));
    });
  });
}

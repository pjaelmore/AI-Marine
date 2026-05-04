import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/services/calculator/modifiers/tide_phase_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

/// Striper-flavored tide preferences for tests: strongly prefers
/// the moving water (rising/falling) over the slack windows.
const _stripedBassPref = TidePreference(
  phaseWeights: {
    TidePhase.rising: 0.9,
    TidePhase.falling: 0.7,
    TidePhase.slackHigh: 0.2,
    TidePhase.slackLow: 0.1,
  },
);

void main() {
  group('evaluateTidePhaseModifier — envelope', () {
    test('returns ModifierApplication with name and rangeMin/rangeMax', () {
      final r = evaluateTidePhaseModifier(
        phase: TidePhase.rising,
        preference: _stripedBassPref,
      );
      expect(r.name, 'tide_phase');
      expect(r.rangeMin, 0);
      expect(r.rangeMax, 2);
    });

    test('description names the phase and surfaces the weight', () {
      final r = evaluateTidePhaseModifier(
        phase: TidePhase.slackHigh,
        preference: _stripedBassPref,
      );
      expect(r.description, contains('slack high'));
      expect(r.description, contains('0.20'));
    });
  });

  group('evaluateTidePhaseModifier — weight → multiplier', () {
    test('weight 0.9 → multiplier 1.8', () {
      expect(
        evaluateTidePhaseModifier(
          phase: TidePhase.rising,
          preference: _stripedBassPref,
        ).value,
        closeTo(1.8, 1e-9),
      );
    });

    test('weight 0.5 → neutral multiplier 1.0', () {
      const halfPref = TidePreference(
        phaseWeights: {TidePhase.rising: 0.5},
      );
      expect(
        evaluateTidePhaseModifier(
          phase: TidePhase.rising,
          preference: halfPref,
        ).value,
        closeTo(1.0, 1e-9),
      );
    });

    test('weight 1.0 → max multiplier 2.0', () {
      const maxPref = TidePreference(
        phaseWeights: {TidePhase.rising: 1.0},
      );
      expect(
        evaluateTidePhaseModifier(
          phase: TidePhase.rising,
          preference: maxPref,
        ).value,
        2.0,
      );
    });

    test('weight 0.0 → multiplier 0', () {
      const zeroPref = TidePreference(
        phaseWeights: {TidePhase.rising: 0.0},
      );
      expect(
        evaluateTidePhaseModifier(
          phase: TidePhase.rising,
          preference: zeroPref,
        ).value,
        0,
      );
    });
  });

  group('evaluateTidePhaseModifier — missing keys', () {
    test('phase absent from phaseWeights returns multiplier 0', () {
      // Preference only specifies rising; query for falling.
      const partialPref = TidePreference(
        phaseWeights: {TidePhase.rising: 0.9},
      );
      expect(
        evaluateTidePhaseModifier(
          phase: TidePhase.falling,
          preference: partialPref,
        ).value,
        0,
      );
    });

    test('empty phaseWeights returns 0 for every phase', () {
      const emptyPref = TidePreference(
        phaseWeights: <TidePhase, double>{},
      );
      for (final phase in TidePhase.values) {
        expect(
          evaluateTidePhaseModifier(
            phase: phase,
            preference: emptyPref,
          ).value,
          0,
          reason: 'phase $phase should default to 0 with empty map',
        );
      }
    });
  });

  group('evaluateTidePhaseModifier — all four phases', () {
    test('each phase reads its own weight and doubles to multiplier', () {
      for (final entry in _stripedBassPref.phaseWeights.entries) {
        expect(
          evaluateTidePhaseModifier(
            phase: entry.key,
            preference: _stripedBassPref,
          ).value,
          closeTo(entry.value * 2, 1e-9),
          reason: 'phase ${entry.key} weight ${entry.value}',
        );
      }
    });
  });
}

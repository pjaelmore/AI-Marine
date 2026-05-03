import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:flutter_test/flutter_test.dart';

ReasoningBreakdown _sampleReasoning() => const ReasoningBreakdown(
      baseProbability: 0.62,
      gates: [
        GateResult(name: 'Migration presence', passed: true),
        GateResult(name: 'Regulatory closure', passed: true),
      ],
      modifiers: [
        ModifierApplication(
          name: 'Temperature match',
          value: 1.15,
          rangeMin: 0.5,
          rangeMax: 1.5,
          description: 'Water temp near optimal range.',
        ),
        ModifierApplication(
          name: 'Tide phase',
          value: 0.95,
          rangeMin: 0.5,
          rangeMax: 1.5,
          description: 'Slack low — slightly off ideal.',
        ),
      ],
      contributors: [
        ContributorApplication(
          name: 'Personal history',
          value: 1.2,
          rangeMax: 2.0,
          description: 'Prior catches within 0.25 nm.',
        ),
      ],
      rawScoreBeforeContributors: 6.78,
      additiveTotal: 1.2,
      finalScore: 7.98,
      migrationSummary: 'Spring run in full swing.',
      suggestedApproach: 'Live eels on the falling tide.',
    );

void main() {
  group('GateResult JSON round-trip', () {
    test('preserves passed gates', () {
      const original = GateResult(name: 'Migration presence', passed: true);
      expect(GateResult.fromJson(original.toJson()), original);
    });

    test('preserves failed gates with reason text', () {
      const original = GateResult(
        name: 'Hard temperature bound',
        passed: false,
        failureReason: 'Water temp 38°F below tolerance floor of 50°F.',
      );
      expect(GateResult.fromJson(original.toJson()), original);
    });
  });

  group('ModifierApplication / ContributorApplication JSON round-trip', () {
    test('preserves all numeric framing fields', () {
      const m = ModifierApplication(
        name: 'Temperature match',
        value: 1.15,
        rangeMin: 0.5,
        rangeMax: 1.5,
        description: 'Optimal range.',
      );
      expect(ModifierApplication.fromJson(m.toJson()), m);

      const c = ContributorApplication(
        name: 'Personal history',
        value: 1.2,
        rangeMax: 2.0,
        description: 'Prior catches nearby.',
      );
      expect(ContributorApplication.fromJson(c.toJson()), c);
    });
  });

  group('ReasoningBreakdown JSON round-trip', () {
    test('preserves gates, modifiers, and contributors', () {
      final original = _sampleReasoning();
      final restored = ReasoningBreakdown.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.gates, hasLength(2));
      expect(restored.modifiers, hasLength(2));
      expect(restored.contributors, hasLength(1));
    });
  });

  group('ScoreResult JSON round-trip', () {
    test('preserves location, time, score, and reasoning', () {
      final original = ScoreResult(
        speciesId: 'striped_bass',
        location: const LatLng(latitude: 42.36, longitude: -70.55),
        time: DateTime.utc(2026, 5, 22, 18, 0),
        finalScore: 7.98,
        confidence: 0.92,
        reasoning: _sampleReasoning(),
      );
      final restored = ScoreResult.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.location.latitude, 42.36);
      expect(restored.reasoning.finalScore, original.finalScore);
    });
  });
}

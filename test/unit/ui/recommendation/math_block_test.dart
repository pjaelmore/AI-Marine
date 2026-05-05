import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/math_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ReasoningBreakdown _reasoning({
  double rawScoreBeforeContributors = 7.06,
  double additiveTotal = 1.75,
  double finalScore = 8.81,
}) =>
    ReasoningBreakdown(
      baseProbability: 0.95,
      gates: const [],
      modifiers: const [],
      contributors: const [],
      rawScoreBeforeContributors: rawScoreBeforeContributors,
      additiveTotal: additiveTotal,
      finalScore: finalScore,
      migrationSummary: '',
      suggestedApproach: '',
    );

Widget _harness(Widget child) {
  return MaterialApp(
    theme: buildMarineTheme(),
    home: Scaffold(
      body: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    ),
  );
}

void main() {
  group('MathBlock', () {
    testWidgets('renders all three rows with two-decimal values',
        (tester) async {
      await tester.pumpWidget(
        _harness(MathBlock(reasoning: _reasoning())),
      );
      // Row labels.
      expect(find.text('Base × modifiers'), findsOneWidget);
      expect(find.text('+ Contributors'), findsOneWidget);
      expect(find.text('Final'), findsOneWidget);
      // Values, fixed to 2 decimals.
      expect(find.text('7.06'), findsOneWidget);
      expect(find.text('1.75'), findsOneWidget);
      expect(find.text('8.81'), findsOneWidget);
    });

    testWidgets('renders a divider between contributors and final',
        (tester) async {
      await tester.pumpWidget(
        _harness(MathBlock(reasoning: _reasoning())),
      );
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('zeroed contributors still produce a "+ 0.00" row',
        (tester) async {
      // When no contributors fire, additiveTotal == 0. The math block
      // should still render the row (so the user sees "0 added" rather
      // than wondering whether the row got dropped).
      await tester.pumpWidget(
        _harness(
          MathBlock(
            reasoning: _reasoning(
              rawScoreBeforeContributors: 6.5,
              additiveTotal: 0,
              finalScore: 6.5,
            ),
          ),
        ),
      );
      expect(find.text('+ Contributors'), findsOneWidget);
      expect(find.text('0.00'), findsOneWidget);
      // Both raw and final are 6.5 → there should be two "6.50" texts.
      expect(find.text('6.50'), findsNWidgets(2));
    });

    testWidgets('handles 10.0 final score (perfect day)', (tester) async {
      await tester.pumpWidget(
        _harness(
          MathBlock(
            reasoning: _reasoning(
              rawScoreBeforeContributors: 8.5,
              additiveTotal: 1.5,
              finalScore: 10.0,
            ),
          ),
        ),
      );
      expect(find.text('10.00'), findsOneWidget);
    });
  });
}

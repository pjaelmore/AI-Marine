import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/suggested_approach_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
  group('SuggestedApproachBlock', () {
    testWidgets('renders the SUGGESTED APPROACH label and the body text',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          const SuggestedApproachBlock(
            approach: 'Live pinfish on the channel edge.',
          ),
        ),
      );
      expect(find.text('SUGGESTED APPROACH'), findsOneWidget);
      expect(
        find.text('Live pinfish on the channel edge.'),
        findsOneWidget,
      );
    });

    testWidgets('renders multi-sentence approach without truncation',
        (tester) async {
      const longApproach =
          'Dawn or dusk on the falling tide. Live pinfish or shrimp on '
          'the channel edge — snook stack here as bait drains off the '
          'grass flats.';
      await tester.pumpWidget(
        _harness(const SuggestedApproachBlock(approach: longApproach)),
      );
      expect(find.text(longApproach), findsOneWidget);
    });

    testWidgets('empty approach still renders the label without crashing',
        (tester) async {
      // Defensive: a species with no suggestedApproach string falls
      // through to "" rather than null. The block should not paint
      // exceptions in that case.
      await tester.pumpWidget(
        _harness(const SuggestedApproachBlock(approach: '')),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('SUGGESTED APPROACH'), findsOneWidget);
    });
  });
}

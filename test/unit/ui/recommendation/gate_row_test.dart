import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/gate_row.dart';
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
  group('GateRow — pass state', () {
    testWidgets('humanizes the gate name and renders a check icon',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          const GateRow(
            gate: GateResult(name: 'migration_presence', passed: true),
          ),
        ),
      );
      expect(find.text('Migration presence'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('passing gate omits the failure-reason subtitle',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          const GateRow(
            gate: GateResult(
              name: 'migration_presence',
              passed: true,
              // Even with a reason set, passing shouldn't show it —
              // the field is meaningful only on failure.
              failureReason: 'should not appear',
            ),
          ),
        ),
      );
      expect(find.text('should not appear'), findsNothing);
    });
  });

  group('GateRow — fail state', () {
    testWidgets('renders the error icon and the failure reason',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          const GateRow(
            gate: GateResult(
              name: 'migration_presence',
              passed: false,
              failureReason:
                  'no presence for region tampa_bay this week of year',
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Migration presence'), findsOneWidget);
      expect(
        find.text('no presence for region tampa_bay this week of year'),
        findsOneWidget,
      );
    });

    testWidgets('failing gate without a reason renders only the name',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          const GateRow(
            gate: GateResult(name: 'migration_presence', passed: false),
          ),
        ),
      );
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      // Only the name; no second text widget for the reason.
      expect(find.byType(Text), findsOneWidget);
    });
  });
}

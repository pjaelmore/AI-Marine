import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/contributor_bar_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ContributorApplication _con({
  required String name,
  required double value,
  String description = 'desc',
  double rangeMax = 1.0,
}) =>
    ContributorApplication(
      name: name,
      value: value,
      rangeMax: rangeMax,
      description: description,
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
  group('ContributorBarTile — non-zero value', () {
    testWidgets('humanizes snake_case names and renders +N.NN', (tester) async {
      await tester.pumpWidget(
        _harness(
          ContributorBarTile(
            contributor: _con(name: 'time_of_day', value: 0.85),
          ),
        ),
      );
      expect(find.text('Time of day'), findsOneWidget);
      expect(find.text('+0.85'), findsOneWidget);
    });

    testWidgets('description renders below the bar', (tester) async {
      await tester.pumpWidget(
        _harness(
          ContributorBarTile(
            contributor: _con(
              name: 'structure_proximity',
              value: 0.9,
              description: 'Channel-edge match in species data',
            ),
          ),
        ),
      );
      expect(
        find.text('Channel-edge match in species data'),
        findsOneWidget,
      );
    });

    testWidgets(
      'value exceeding rangeMax clamps without overflow',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            ContributorBarTile(
              contributor: _con(name: 'recent_catches', value: 5.0),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        expect(find.text('+5.00'), findsOneWidget);
      },
    );
  });

  group('ContributorBarTile — zero-value muted treatment', () {
    testWidgets(
      'zero-value contributor renders an em dash instead of +0.00',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            ContributorBarTile(
              contributor: _con(name: 'recent_catches', value: 0),
            ),
          ),
        );
        expect(find.text('—'), findsOneWidget);
        expect(find.text('+0.00'), findsNothing);
      },
    );

    testWidgets(
      'zero-value still shows the description (italicized via the widget)',
      (tester) async {
        // The description is the user-facing explanation for zero —
        // e.g. "No catches logged here yet." Keep it visible even when
        // value == 0.
        await tester.pumpWidget(
          _harness(
            ContributorBarTile(
              contributor: _con(
                name: 'recent_catches',
                value: 0,
                description: 'No catches logged here yet',
              ),
            ),
          ),
        );
        expect(find.text('No catches logged here yet'), findsOneWidget);
      },
    );
  });
}

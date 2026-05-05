import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/modifier_bar_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ModifierApplication _mod({
  required String name,
  required double value,
  String description = 'desc',
  double rangeMin = 0,
  double rangeMax = 2,
}) =>
    ModifierApplication(
      name: name,
      value: value,
      rangeMin: rangeMin,
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
  group('ModifierBarTile — verified bar', () {
    testWidgets('humanizes snake_case names for display', (tester) async {
      await tester.pumpWidget(
        _harness(
          ModifierBarTile(
            modifier: _mod(name: 'water_temperature', value: 2.0),
          ),
        ),
      );
      expect(find.text('Water temperature'), findsOneWidget);
    });

    testWidgets('renders the multiplier with two decimals when < 10',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          ModifierBarTile(
            modifier: _mod(name: 'tide_phase', value: 1.5),
          ),
        ),
      );
      expect(find.text('×1.50'), findsOneWidget);
    });

    testWidgets('renders the description below the bar', (tester) async {
      await tester.pumpWidget(
        _harness(
          ModifierBarTile(
            modifier: _mod(
              name: 'tide_phase',
              value: 1.5,
              description: 'Falling tide drains bait off the flats',
            ),
          ),
        ),
      );
      expect(
        find.text('Falling tide drains bait off the flats'),
        findsOneWidget,
      );
    });

    testWidgets(
      'value beyond rangeMax clamps to bar end (does not overflow)',
      (tester) async {
        // Defensively constructed: a poorly-tuned modifier returning
        // 3.0 on a [0, 2] envelope still positions the dot at the
        // right edge rather than escaping the track.
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: _mod(name: 'wind_speed', value: 3.0),
            ),
          ),
        );
        // Just assert it renders without overflow / paint exceptions.
        expect(tester.takeException(), isNull);
        expect(find.text('×3.00'), findsOneWidget);
      },
    );

    testWidgets(
      'value below rangeMin clamps to bar start (does not overflow)',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: _mod(name: 'wind_speed', value: -0.5),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      },
    );
  });

  group('ModifierBarTile — unverified row', () {
    testWidgets('renders the UNVERIFIED badge and humanized name',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          ModifierBarTile(
            modifier: _mod(name: 'solunar_window', value: 1.6),
            unverified: true,
          ),
        ),
      );
      expect(find.text('UNVERIFIED'), findsOneWidget);
      expect(find.text('Solunar window'), findsOneWidget);
    });

    testWidgets(
      'unverified row deliberately omits the multiplier number',
      (tester) async {
        // The whole point of the muted row is to avoid suggesting the
        // value matters — no ×N.NN, no description, no bar.
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: _mod(
                name: 'barometric_trend',
                value: 1.4,
                description: 'Falling pressure',
              ),
              unverified: true,
            ),
          ),
        );
        expect(find.text('×1.40'), findsNothing);
        expect(find.text('Falling pressure'), findsNothing);
      },
    );
  });
}

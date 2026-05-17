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

    testWidgets(
      'renders the Observed time subtitle when modifier.observedAt is set',
      (tester) async {
        // Buoy readings can be 10–50 min old at NDBC's realtime2 cadence —
        // the subtitle is the only signal the user has for "is this fresh
        // or stale?"
        final observedAt = DateTime.utc(2026, 5, 16, 23, 23); // 23:23 UTC
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: ModifierApplication(
                name: 'water_temperature',
                value: 1.8,
                rangeMin: 0,
                rangeMax: 2,
                description: 'Water 78°F vs optimal 80–82°F',
                observedAt: observedAt,
              ),
            ),
          ),
        );
        // Local time will vary by test-runner host; just assert the
        // "Observed " prefix is present so the test is portable.
        expect(
          find.byWidgetPredicate(
            (w) => w is Text && (w.data ?? '').startsWith('Observed '),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'no Observed subtitle when modifier.observedAt is null',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: _mod(name: 'time_of_day', value: 1.5),
            ),
          ),
        );
        expect(
          find.byWidgetPredicate(
            (w) => w is Text && (w.data ?? '').startsWith('Observed '),
          ),
          findsNothing,
        );
      },
    );
  });

  group('ModifierBarTile — unavailable row', () {
    ModifierApplication unavailable(String name, String description) =>
        ModifierApplication(
          name: name,
          value: 0,
          rangeMin: 0,
          rangeMax: 2,
          description: description,
          available: false,
        );

    testWidgets('renders the NO DATA badge and humanized name', (tester) async {
      await tester.pumpWidget(
        _harness(
          ModifierBarTile(
            modifier: unavailable('depth', 'No bathymetry data for this spot'),
          ),
        ),
      );
      expect(find.text('NO DATA'), findsOneWidget);
      expect(find.text('Depth'), findsOneWidget);
    });

    testWidgets(
      'surfaces the calculator-provided reason so the user knows *why*',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: unavailable(
                'water_temperature',
                'No NDBC station in range',
              ),
            ),
          ),
        );
        expect(find.text('No NDBC station in range'), findsOneWidget);
      },
    );

    testWidgets(
      'unavailable row deliberately omits the multiplier number and the bar',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: unavailable('tide_phase', 'No tide station in range'),
            ),
          ),
        );
        // The whole point of the muted row: no ×N.NN value, since the
        // modifier didn't actually fire.
        expect(find.text('×0.00'), findsNothing);
      },
    );

    testWidgets(
      'unavailable takes precedence over `unverified` parameter',
      (tester) async {
        // If the species data is unverified AND the sensor is out,
        // showing UNVERIFIED would imply we have a reading we're unsure
        // about — but we have no reading at all. The unavailable row
        // is the truer signal.
        await tester.pumpWidget(
          _harness(
            ModifierBarTile(
              modifier: unavailable('solunar_window', 'Solunar unavailable'),
              unverified: true,
            ),
          ),
        );
        expect(find.text('NO DATA'), findsOneWidget);
        expect(find.text('UNVERIFIED'), findsNothing);
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

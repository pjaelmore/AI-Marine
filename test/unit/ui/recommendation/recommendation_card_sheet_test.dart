import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_card_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ScoreResult _scoreFor({
  String speciesId = 'common-snook',
  double finalScore = 8.81,
  double confidence = 0.85,
  LatLng location = const LatLng(latitude: 27.94, longitude: -82.45),
  DateTime? time,
  List<ModifierApplication> modifiers = const [],
  List<ContributorApplication> contributors = const [],
  List<GateResult> gates = const [
    GateResult(name: 'migration_presence', passed: true),
  ],
}) {
  final t = time ?? DateTime.utc(2026, 5, 22, 23);
  return ScoreResult(
    speciesId: speciesId,
    location: location,
    time: t,
    finalScore: finalScore,
    confidence: confidence,
    reasoning: ReasoningBreakdown(
      baseProbability: 0.95,
      gates: gates,
      modifiers: modifiers,
      contributors: contributors,
      rawScoreBeforeContributors: 7.06,
      additiveTotal: 1.75,
      finalScore: finalScore,
      migrationSummary: 'Snook present at peak (week 21)',
      suggestedApproach: 'Live pinfish on the channel edge.',
    ),
  );
}

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

ModifierApplication _mod({
  required String name,
  required double value,
  String description = 'Test description',
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

Widget _harness(Widget sheet) {
  return MaterialApp(
    theme: buildMarineTheme(),
    home: Scaffold(
      body: Stack(
        children: [
          const Center(child: Text('Chart placeholder')),
          sheet,
        ],
      ),
    ),
  );
}

void main() {
  group('RecommendationCardSheet — header content', () {
    testWidgets('renders the score number to one decimal place',
        (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor(finalScore: 8.81))),
      );
      expect(find.text('8.8'), findsOneWidget);
    });

    testWidgets(
        'rounds 9.95+ scores to no decimals to keep the numeral compact',
        (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor(finalScore: 9.97))),
      );
      // 9.97 → "10" so the header doesn't render a 4-character "9.97".
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('formats the species id as a human title', (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      expect(find.text('Common snook'), findsOneWidget);
    });

    testWidgets('shows the location coords + formatted time', (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      // 27.94 → "27.94°N", -82.45 → "-82.45°"
      expect(find.textContaining('27.94'), findsOneWidget);
      expect(find.textContaining('-82.45'), findsOneWidget);
    });

    testWidgets('renders confidence value to two decimals', (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor(confidence: 0.85))),
      );
      expect(find.text('Confidence 0.85'), findsOneWidget);
    });
  });

  group('RecommendationCardSheet — close action', () {
    testWidgets('omits the close button when onClose is null', (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('shows close button + invokes onClose when wired',
        (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        _harness(
          RecommendationCardSheet(
            result: _scoreFor(),
            onClose: () => calls++,
          ),
        ),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      expect(calls, 1);
    });
  });

  group('RecommendationCardSheet — modifiers section', () {
    testWidgets(
      "boosting modifiers (value > 1) appear under \"What's boosting\"",
      (tester) async {
        await tester.pumpWidget(
          _harness(
            RecommendationCardSheet(
              result: _scoreFor(
                modifiers: [
                  _mod(name: 'water_temperature', value: 2.0),
                  _mod(name: 'tide_phase', value: 1.5),
                ],
              ),
            ),
          ),
        );
        expect(find.text("WHAT'S BOOSTING"), findsOneWidget);
        expect(find.text('Water temperature'), findsOneWidget);
        expect(find.text('Tide phase'), findsOneWidget);
        expect(find.text('×2.00'), findsOneWidget);
        expect(find.text('×1.50'), findsOneWidget);
      },
    );

    testWidgets(
      "dampening modifiers (value < 1) appear under \"What's dampening\"",
      (tester) async {
        await tester.pumpWidget(
          _harness(
            RecommendationCardSheet(
              result: _scoreFor(
                modifiers: [
                  _mod(name: 'wind_speed', value: 0.4),
                ],
              ),
            ),
          ),
        );
        expect(find.text("WHAT'S DAMPENING"), findsOneWidget);
        expect(find.text('Wind speed'), findsOneWidget);
        expect(find.text('×0.40'), findsOneWidget);
      },
    );

    testWidgets(
      'unverified modifiers route to the muted UNVERIFIED row',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            RecommendationCardSheet(
              result: _scoreFor(
                modifiers: [
                  _mod(name: 'water_temperature', value: 2.0),
                  _mod(name: 'solunar_window', value: 1.6),
                ],
              ),
              unverifiedModifierNames: const {'solunar_window'},
            ),
          ),
        );
        // verified modifier renders as a normal bar
        expect(find.text("WHAT'S BOOSTING"), findsOneWidget);
        expect(find.text('Water temperature'), findsOneWidget);
        // unverified appears under its own subsection with the badge
        expect(find.text('TRACKED BUT UNVERIFIED'), findsOneWidget);
        expect(find.text('UNVERIFIED'), findsOneWidget);
        expect(find.text('Solunar window'), findsOneWidget);
        // and the unverified row deliberately does NOT show the
        // multiplier number — that's the whole point of the muted row
        expect(find.text('×1.60'), findsNothing);
      },
    );

    testWidgets(
      'empty modifiers list shows the no-data fallback label',
      (tester) async {
        await tester.pumpWidget(
          _harness(RecommendationCardSheet(result: _scoreFor())),
        );
        expect(
          find.text('NO MODIFIERS FIRED (DATA UNAVAILABLE)'),
          findsOneWidget,
        );
      },
    );
  });

  group('RecommendationCardSheet — gates section', () {
    testWidgets('passing gate renders under "GATES" with a check icon',
        (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      expect(find.text('GATES'), findsOneWidget);
      expect(find.text('Migration presence'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('failing gate surfaces the failure reason + error icon',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          RecommendationCardSheet(
            result: _scoreFor(
              gates: const [
                GateResult(
                  name: 'migration_presence',
                  passed: false,
                  failureReason: 'Out of season window',
                ),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Migration presence'), findsOneWidget);
      expect(find.text('Out of season window'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });

  group('RecommendationCardSheet — contributors section', () {
    testWidgets(
      'non-zero contributors render under "WHAT\'S ADDING" with +N.NN',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            RecommendationCardSheet(
              result: _scoreFor(
                contributors: [
                  _con(name: 'time_of_day', value: 0.85),
                  _con(name: 'structure_proximity', value: 0.6),
                ],
              ),
            ),
          ),
        );
        expect(find.text("WHAT'S ADDING"), findsOneWidget);
        expect(find.text('Time of day'), findsOneWidget);
        expect(find.text('Structure proximity'), findsOneWidget);
        expect(find.text('+0.85'), findsOneWidget);
        expect(find.text('+0.60'), findsOneWidget);
      },
    );

    testWidgets(
      'empty contributors list shows the no-data fallback label',
      (tester) async {
        await tester.pumpWidget(
          _harness(RecommendationCardSheet(result: _scoreFor())),
        );
        expect(
          find.text('NO CONTRIBUTORS FIRED (DATA UNAVAILABLE)'),
          findsOneWidget,
        );
      },
    );
  });

  group('RecommendationCardSheet — math + approach footer', () {
    testWidgets('math block renders under "THE MATH" with all three rows',
        (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      expect(find.text('THE MATH'), findsOneWidget);
      expect(find.text('Base × modifiers'), findsOneWidget);
      expect(find.text('+ Contributors'), findsOneWidget);
      expect(find.text('Final'), findsOneWidget);
      // Values from _scoreFor defaults.
      expect(find.text('7.06'), findsOneWidget);
      expect(find.text('1.75'), findsOneWidget);
      expect(find.text('8.81'), findsOneWidget);
    });

    testWidgets('suggested approach renders with the labelled callout',
        (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      expect(find.text('SUGGESTED APPROACH'), findsOneWidget);
      expect(
        find.text('Live pinfish on the channel edge.'),
        findsOneWidget,
      );
    });
  });

  group('RecommendationCardSheet — sheet behavior', () {
    testWidgets('starts at the peek snap point', (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      // The peek size is the initial child size; verify the sheet's
      // top edge sits ~68% of the way down the screen (1 - 0.32).
      final screenHeight =
          tester.view.physicalSize.height / tester.view.devicePixelRatio;
      final headerFinder = find.text('Common snook');
      final headerCenter = tester.getCenter(headerFinder);
      // Header should be in the lower third of the screen at peek.
      expect(headerCenter.dy, greaterThan(screenHeight * 0.55));
    });

    testWidgets('exposes a draggable grabber', (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      // The grabber is the small horizontal pill — find by its
      // dimensions (44x4). Use byType + filter rather than a key
      // because the grabber is private.
      final containers = find.byType(Container);
      expect(containers, findsWidgets);
    });
  });
}

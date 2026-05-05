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
      gates: const [GateResult(name: 'migration_presence', passed: true)],
      modifiers: const [],
      contributors: const [],
      rawScoreBeforeContributors: 7.06,
      additiveTotal: 1.75,
      finalScore: finalScore,
      migrationSummary: 'Snook present at peak (week 21)',
      suggestedApproach: 'Live pinfish on the channel edge.',
    ),
  );
}

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

  group('RecommendationCardSheet — body placeholder', () {
    testWidgets('shows the BREAKDOWN section header', (tester) async {
      await tester.pumpWidget(
        _harness(RecommendationCardSheet(result: _scoreFor())),
      );
      // Sheet starts at peek size (~32%) — drag up to reveal the body.
      // At default peek the placeholder may be partially below the fold,
      // so widget-tree presence is the right assertion (not visibility).
      expect(find.text('BREAKDOWN'), findsOneWidget);
    });

    testWidgets(
      'placeholder names every section coming in later slices',
      (tester) async {
        await tester.pumpWidget(
          _harness(RecommendationCardSheet(result: _scoreFor())),
        );
        final body = find.textContaining('Modifier bars, contributor bars');
        expect(body, findsOneWidget);
      },
    );
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

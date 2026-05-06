import 'dart:async';

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/state/engine_providers.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_card_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_empty_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_error_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_loading_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _tap = LatLng(latitude: 27.94, longitude: -82.45);
final _fixedTime = DateTime.utc(2026, 5, 22, 23);

ScoreResult _result() => ScoreResult(
      speciesId: 'common-snook',
      location: _tap,
      time: _fixedTime,
      finalScore: 8.81,
      confidence: 0.85,
      reasoning: const ReasoningBreakdown(
        baseProbability: 0.95,
        gates: [GateResult(name: 'migration_presence', passed: true)],
        modifiers: [],
        contributors: [],
        rawScoreBeforeContributors: 7.06,
        additiveTotal: 1.75,
        finalScore: 8.81,
        migrationSummary: 'Snook present at peak',
        suggestedApproach: 'Live pinfish on the channel edge.',
      ),
    );

Widget _harness({
  required LatLng? tap,
  required VoidCallback onDismiss,
  required List<Override> overrides,
}) {
  return ProviderScope(
    overrides: [
      selectedSpeciesIdProvider.overrideWith((ref) => 'common-snook'),
      selectedTimeProvider.overrideWith((ref) => _fixedTime),
      ...overrides,
    ],
    child: MaterialApp(
      theme: buildMarineTheme(),
      home: Scaffold(
        body: Stack(
          children: [
            const Center(child: Text('Chart placeholder')),
            RecommendationOverlay(
              tappedLocation: tap,
              onDismiss: onDismiss,
            ),
          ],
        ),
      ),
    ),
  );
}

void main() {
  group('RecommendationOverlay — empty state', () {
    testWidgets('null tap renders the empty sheet', (tester) async {
      await tester.pumpWidget(
        _harness(tap: null, onDismiss: () {}, overrides: const []),
      );
      expect(find.byType(RecommendationEmptySheet), findsOneWidget);
      expect(find.byType(RecommendationCardSheet), findsNothing);
      expect(find.byType(RecommendationLoadingSheet), findsNothing);
      expect(find.byType(RecommendationErrorSheet), findsNothing);
    });
  });

  group('RecommendationOverlay — loading state', () {
    testWidgets('a tap with the score in flight renders the loading sheet',
        (tester) async {
      // Future that never completes — keeps the AsyncValue in loading.
      final never = Completer<ScoreResult>();
      addTearDown(() {
        if (!never.isCompleted) never.complete(_result());
      });

      await tester.pumpWidget(
        _harness(
          tap: _tap,
          onDismiss: () {},
          overrides: [
            scoreAtLocationProvider.overrideWith((ref, query) => never.future),
          ],
        ),
      );
      await tester.pump();
      expect(find.byType(RecommendationLoadingSheet), findsOneWidget);
    });
  });

  group('RecommendationOverlay — error state', () {
    testWidgets('thrown error renders the error sheet with the message',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          tap: _tap,
          onDismiss: () {},
          overrides: [
            scoreAtLocationProvider.overrideWith(
              (ref, query) => Future.error(
                Exception('No internet connection'),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RecommendationErrorSheet), findsOneWidget);
      // The "Exception: " prefix is stripped before display.
      expect(find.text('No internet connection'), findsOneWidget);
      expect(find.text('Exception: No internet connection'), findsNothing);
    });

    testWidgets(
      'tapping retry re-fetches and resolves the data state on the second '
      'attempt',
      (tester) async {
        // First call throws, second call returns data — after the retry
        // tap the overlay should swap to the card sheet.
        var calls = 0;
        await tester.pumpWidget(
          _harness(
            tap: _tap,
            onDismiss: () {},
            overrides: [
              scoreAtLocationProvider.overrideWith((ref, query) {
                calls++;
                if (calls == 1) {
                  return Future.error(Exception('First-attempt failure'));
                }
                return Future.value(_result());
              }),
            ],
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(RecommendationErrorSheet), findsOneWidget);

        await tester.tap(find.text('Try again'));
        await tester.pumpAndSettle();
        expect(find.byType(RecommendationCardSheet), findsOneWidget);
        expect(calls, 2);
      },
    );
  });

  group('RecommendationOverlay — data state', () {
    testWidgets('a resolved score renders the recommendation card',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          tap: _tap,
          onDismiss: () {},
          overrides: [
            scoreAtLocationProvider.overrideWith(
              (ref, query) => Future.value(_result()),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RecommendationCardSheet), findsOneWidget);
      // Sanity: the card actually rendered the result's species name.
      expect(find.text('Common snook'), findsOneWidget);
    });

    testWidgets('tapping close on the card invokes onDismiss', (tester) async {
      var dismissed = 0;
      await tester.pumpWidget(
        _harness(
          tap: _tap,
          onDismiss: () => dismissed++,
          overrides: [
            scoreAtLocationProvider.overrideWith(
              (ref, query) => Future.value(_result()),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(dismissed, 1);
    });
  });
}

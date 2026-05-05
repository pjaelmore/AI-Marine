import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_error_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/sheet_chrome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) {
  return MaterialApp(
    theme: buildMarineTheme(),
    home: Scaffold(
      body: Stack(
        children: [
          const Center(child: Text('Chart placeholder')),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 400,
              child: child,
            ),
          ),
        ],
      ),
    ),
  );
}

void main() {
  group('RecommendationErrorSheet', () {
    testWidgets('renders the headline + the supplied message', (tester) async {
      await tester.pumpWidget(
        _harness(
          const RecommendationErrorSheet(
            message: 'No internet connection',
          ),
        ),
      );
      expect(
        find.text("Couldn't calculate recommendation"),
        findsOneWidget,
      );
      expect(find.text('No internet connection'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('omits the retry button when onRetry is null', (tester) async {
      await tester.pumpWidget(
        _harness(
          const RecommendationErrorSheet(message: 'Unavailable'),
        ),
      );
      expect(find.text('Try again'), findsNothing);
      expect(find.byIcon(Icons.refresh), findsNothing);
    });

    testWidgets('shows the retry button + invokes onRetry when wired',
        (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        _harness(
          RecommendationErrorSheet(
            message: 'Unavailable',
            onRetry: () => calls++,
          ),
        ),
      );
      expect(find.text('Try again'), findsOneWidget);
      await tester.tap(find.text('Try again'));
      expect(calls, 1);
    });

    testWidgets('reuses the SheetChrome shell + grabber', (tester) async {
      await tester.pumpWidget(
        _harness(
          const RecommendationErrorSheet(message: 'Unavailable'),
        ),
      );
      expect(find.byType(SheetChrome), findsOneWidget);
      expect(find.byType(SheetGrabber), findsOneWidget);
    });
  });
}

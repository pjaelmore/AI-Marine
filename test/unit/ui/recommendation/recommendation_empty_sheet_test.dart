import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_empty_sheet.dart';
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
  group('RecommendationEmptySheet', () {
    testWidgets('renders the tap-prompt copy + a touch icon', (tester) async {
      await tester.pumpWidget(
        _harness(const RecommendationEmptySheet()),
      );
      expect(
        find.text('Tap a spot on the chart to see a recommendation.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.touch_app_outlined), findsOneWidget);
    });

    testWidgets('reuses the SheetChrome shell + grabber', (tester) async {
      await tester.pumpWidget(
        _harness(const RecommendationEmptySheet()),
      );
      expect(find.byType(SheetChrome), findsOneWidget);
      expect(find.byType(SheetGrabber), findsOneWidget);
    });
  });
}

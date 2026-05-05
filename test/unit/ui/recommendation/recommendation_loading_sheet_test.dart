import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_loading_sheet.dart';
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
  group('RecommendationLoadingSheet', () {
    testWidgets('renders the calculating caption', (tester) async {
      await tester.pumpWidget(
        _harness(const RecommendationLoadingSheet()),
      );
      await tester.pump();
      expect(find.text('Calculating recommendation…'), findsOneWidget);
    });

    testWidgets('shows a circular progress indicator', (tester) async {
      await tester.pumpWidget(
        _harness(const RecommendationLoadingSheet()),
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('reuses the SheetChrome shell + grabber', (tester) async {
      // The state widgets must look like the same surface as the real
      // card so the loading→loaded transition feels like content swap,
      // not container swap.
      await tester.pumpWidget(
        _harness(const RecommendationLoadingSheet()),
      );
      await tester.pump();
      expect(find.byType(SheetChrome), findsOneWidget);
      expect(find.byType(SheetGrabber), findsOneWidget);
    });
  });
}

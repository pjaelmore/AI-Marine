import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_marine_engine/app.dart';

void main() {
  testWidgets('App boots and shows the Phase 1 placeholder',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: AiMarineApp()),
    );

    expect(find.text('AI Marine Engine'), findsOneWidget);
    expect(find.text('Phase 1 — scaffolding'), findsOneWidget);
    expect(find.byIcon(Icons.anchor), findsOneWidget);
  });
}

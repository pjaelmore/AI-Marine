import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/osm/wreck_record.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/wreck_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _wreck = WreckRecord(
  id: 'node/10158004742',
  name: 'Maple Leaf',
  category: 'non-dangerous',
  depthM: 6.7,
  lat: 30.158,
  lon: -81.68,
);

const _bareWreck = WreckRecord(
  id: 'node/12345',
  lat: 27.0,
  lon: -82.0,
);

Widget _harness(Widget child) {
  return MaterialApp(
    theme: buildMarineTheme(),
    home: Scaffold(
      body: SizedBox(
        width: 400,
        child: Align(alignment: Alignment.bottomCenter, child: child),
      ),
    ),
  );
}

void main() {
  group('WreckInfoSheet — header', () {
    testWidgets('renders the wreck name + OSM id', (tester) async {
      await tester.pumpWidget(
        _harness(const WreckInfoSheet(wreck: _wreck)),
      );
      expect(find.text('Maple Leaf'), findsOneWidget);
      expect(find.textContaining('OSM node/10158004742'), findsOneWidget);
    });

    testWidgets(
      'falls back to "Unnamed wreck" when the upstream tag is empty',
      (tester) async {
        await tester.pumpWidget(
          _harness(const WreckInfoSheet(wreck: _bareWreck)),
        );
        expect(find.text('Unnamed wreck'), findsOneWidget);
      },
    );

    testWidgets('shows distance when vesselPosition is supplied',
        (tester) async {
      // ~1° NW of the wreck → ~60+ nm.
      const vessel = LatLng(latitude: 31.158, longitude: -82.68);
      await tester.pumpWidget(
        _harness(
          const WreckInfoSheet(wreck: _wreck, vesselPosition: vessel),
        ),
      );
      expect(find.textContaining('nm from vessel'), findsOneWidget);
    });

    testWidgets('omits distance when vessel position is null', (tester) async {
      await tester.pumpWidget(
        _harness(const WreckInfoSheet(wreck: _wreck)),
      );
      expect(find.textContaining('from vessel'), findsNothing);
    });

    testWidgets('close button invokes onClose when wired', (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        _harness(
          WreckInfoSheet(wreck: _wreck, onClose: () => calls++),
        ),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      expect(calls, 1);
    });
  });

  group('WreckInfoSheet — detail grid', () {
    testWidgets('formats category with hyphenated → sentence case',
        (tester) async {
      await tester.pumpWidget(
        _harness(const WreckInfoSheet(wreck: _wreck)),
      );
      expect(find.text('Non-dangerous'), findsOneWidget);
    });

    testWidgets('formats depth in feet with metres in parens', (tester) async {
      await tester.pumpWidget(
        _harness(const WreckInfoSheet(wreck: _wreck)),
      );
      // 6.7 m × 3.28084 ≈ 22 ft
      expect(find.text('22 ft (6.7 m)'), findsOneWidget);
    });

    testWidgets('renders an em-dash when category and depth are missing',
        (tester) async {
      await tester.pumpWidget(
        _harness(const WreckInfoSheet(wreck: _bareWreck)),
      );
      // Two missing fields (category + depth) → two em-dashes.
      expect(find.text('—'), findsNWidgets(2));
    });

    testWidgets('formats position with 4-decimal hemisphere notation',
        (tester) async {
      await tester.pumpWidget(
        _harness(const WreckInfoSheet(wreck: _wreck)),
      );
      expect(find.text('30.1580°N, 81.6800°W'), findsOneWidget);
    });

    testWidgets('shows the chart-verification disclaimer', (tester) async {
      await tester.pumpWidget(
        _harness(const WreckInfoSheet(wreck: _wreck)),
      );
      expect(
        find.textContaining('verify against an official chart'),
        findsOneWidget,
      );
    });
  });
}

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/osm/boat_ramp_record.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/boat_ramp_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _ramp = BoatRampRecord(
  id: 'node/123456',
  name: 'Fort De Soto Ramp',
  access: 'yes',
  fee: 'yes',
  surface: 'concrete',
  lat: 27.6252,
  lon: -82.7295,
);

const _bareRamp = BoatRampRecord(
  id: 'node/999',
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
  group('BoatRampInfoSheet — header', () {
    testWidgets('renders the ramp name + OSM id', (tester) async {
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: _ramp)),
      );
      expect(find.text('Fort De Soto Ramp'), findsOneWidget);
      expect(find.textContaining('OSM node/123456'), findsOneWidget);
    });

    testWidgets(
      'falls back to "Unnamed boat ramp" when the name tag is empty',
      (tester) async {
        await tester.pumpWidget(
          _harness(const BoatRampInfoSheet(ramp: _bareRamp)),
        );
        expect(find.text('Unnamed boat ramp'), findsOneWidget);
      },
    );

    testWidgets('shows distance when vesselPosition is supplied',
        (tester) async {
      const vessel = LatLng(latitude: 28.0, longitude: -82.5);
      await tester.pumpWidget(
        _harness(
          const BoatRampInfoSheet(ramp: _ramp, vesselPosition: vessel),
        ),
      );
      expect(find.textContaining('nm from vessel'), findsOneWidget);
    });

    testWidgets('omits distance when vessel position is null', (tester) async {
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: _ramp)),
      );
      expect(find.textContaining('from vessel'), findsNothing);
    });

    testWidgets('close button invokes onClose when wired', (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        _harness(
          BoatRampInfoSheet(ramp: _ramp, onClose: () => calls++),
        ),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      expect(calls, 1);
    });
  });

  group('BoatRampInfoSheet — detail grid', () {
    testWidgets('formats "yes" access as "Public"', (tester) async {
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: _ramp)),
      );
      expect(find.text('Public'), findsOneWidget);
    });

    testWidgets('formats "yes" fee with explicit "fee charged" suffix',
        (tester) async {
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: _ramp)),
      );
      expect(find.text('Yes — fee charged'), findsOneWidget);
    });

    testWidgets('capitalises surface tag', (tester) async {
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: _ramp)),
      );
      expect(find.text('Concrete'), findsOneWidget);
    });

    testWidgets(
      'renders an em-dash when access/fee/surface are all missing',
      (tester) async {
        await tester.pumpWidget(
          _harness(const BoatRampInfoSheet(ramp: _bareRamp)),
        );
        // Three missing fields → three em-dashes.
        expect(find.text('—'), findsNWidgets(3));
      },
    );

    testWidgets('formats position with 4-decimal hemisphere notation',
        (tester) async {
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: _ramp)),
      );
      expect(find.text('27.6252°N, 82.7295°W'), findsOneWidget);
    });

    testWidgets('shows the verify-hours-and-fees disclaimer', (tester) async {
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: _ramp)),
      );
      expect(
        find.textContaining('verify hours and fees'),
        findsOneWidget,
      );
    });

    testWidgets('formats "permit" access as "Permit required"', (tester) async {
      const permitRamp = BoatRampRecord(
        id: 'node/77',
        lat: 27.0,
        lon: -82.0,
        access: 'permit',
      );
      await tester.pumpWidget(
        _harness(const BoatRampInfoSheet(ramp: permitRamp)),
      );
      expect(find.text('Permit required'), findsOneWidget);
    });
  });
}

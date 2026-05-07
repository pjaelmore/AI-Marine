import 'dart:async';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/data/sources/ndbc/buoy_observation.dart';
import 'package:ai_marine_engine/data/sources/ndbc/buoy_station.dart';
import 'package:ai_marine_engine/state/station_observation_providers.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_error_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/recommendation_loading_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/station_info_sheet.dart';
import 'package:ai_marine_engine/ui/recommendation/station_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _station = BuoyStation(
  id: '41113',
  name: 'Cape Canaveral Nearshore',
  lat: 28.4,
  lon: -80.533,
);

ConditionResult<BuoyObservation> _result() {
  final fetchedAt = DateTime.utc(2026, 5, 6, 23, 30);
  return ConditionResult<BuoyObservation>(
    value: BuoyObservation(
      stationId: _station.id,
      timestamp: fetchedAt,
      waterTempC: 25.0,
    ),
    unit: 'composite',
    source: DataSource.noaaNdbc,
    sourceDetails: const SourceDetails(stationId: '41113'),
    fetchedAt: fetchedAt,
    validUntil: fetchedAt.add(const Duration(minutes: 60)),
    confidence: 1.0,
  );
}

Widget _harness({
  required BuoyStation? station,
  required VoidCallback onDismiss,
  required List<Override> overrides,
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: buildMarineTheme(),
      home: Scaffold(
        body: Stack(
          children: [
            const Center(child: Text('Chart placeholder')),
            StationOverlay(
              station: station,
              vesselPosition: null,
              onDismiss: onDismiss,
            ),
          ],
        ),
      ),
    ),
  );
}

void main() {
  group('StationOverlay', () {
    testWidgets('renders nothing when station is null', (tester) async {
      await tester.pumpWidget(
        _harness(station: null, onDismiss: () {}, overrides: const []),
      );
      expect(find.byType(StationInfoSheet), findsNothing);
      expect(find.byType(RecommendationLoadingSheet), findsNothing);
      expect(find.byType(RecommendationErrorSheet), findsNothing);
    });

    testWidgets('shows the loading sheet while the obs is in flight',
        (tester) async {
      final never = Completer<ConditionResult<BuoyObservation>>();
      addTearDown(() {
        if (!never.isCompleted) never.complete(_result());
      });
      await tester.pumpWidget(
        _harness(
          station: _station,
          onDismiss: () {},
          overrides: [
            stationObservationProvider.overrideWith(
              (ref, s) => never.future,
            ),
          ],
        ),
      );
      await tester.pump();
      expect(find.byType(RecommendationLoadingSheet), findsOneWidget);
    });

    testWidgets(
      'shows the error sheet with the cleaned message on failure',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            station: _station,
            onDismiss: () {},
            overrides: [
              stationObservationProvider.overrideWith(
                (ref, s) => Future.error(Exception('NDBC unreachable')),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(RecommendationErrorSheet), findsOneWidget);
        expect(find.text('NDBC unreachable'), findsOneWidget);
      },
    );

    testWidgets('renders the info sheet on success', (tester) async {
      await tester.pumpWidget(
        _harness(
          station: _station,
          onDismiss: () {},
          overrides: [
            stationObservationProvider.overrideWith(
              (ref, s) => Future.value(_result()),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(StationInfoSheet), findsOneWidget);
      expect(find.text('Cape Canaveral Nearshore'), findsOneWidget);
    });

    testWidgets('tap close on info sheet invokes onDismiss', (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        _harness(
          station: _station,
          onDismiss: () => calls++,
          overrides: [
            stationObservationProvider.overrideWith(
              (ref, s) => Future.value(_result()),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(calls, 1);
    });
  });
}

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/ndbc/buoy_observation.dart';
import 'package:ai_marine_engine/data/sources/ndbc/buoy_station.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/recommendation/station_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _capeCanaveral = BuoyStation(
  id: '41113',
  name: 'Cape Canaveral Nearshore',
  lat: 28.4,
  lon: -80.533,
);

final _fetchedAt = DateTime.utc(2026, 5, 6, 23, 30);

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
  group('StationInfoSheet — header', () {
    testWidgets('renders the station name + NDBC id', (tester) async {
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
            ),
            fetchedAt: _fetchedAt,
          ),
        ),
      );
      expect(find.text('Cape Canaveral Nearshore'), findsOneWidget);
      expect(find.text('NDBC 41113'), findsOneWidget);
    });

    testWidgets(
      'shows distance from vessel when vesselPosition is supplied',
      (tester) async {
        // ~30 nm SSE of Cape Canaveral.
        const vessel = LatLng(latitude: 27.95, longitude: -80.33);
        await tester.pumpWidget(
          _harness(
            StationInfoSheet(
              station: _capeCanaveral,
              observation: BuoyObservation(
                stationId: _capeCanaveral.id,
                timestamp: _fetchedAt,
              ),
              fetchedAt: _fetchedAt,
              vesselPosition: vessel,
            ),
          ),
        );
        // Should show "X.X nm from vessel" in the subtitle.
        expect(
          find.textContaining('nm from vessel'),
          findsOneWidget,
        );
      },
    );

    testWidgets('omits distance when vessel position is null', (tester) async {
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
            ),
            fetchedAt: _fetchedAt,
          ),
        ),
      );
      expect(find.textContaining('from vessel'), findsNothing);
      // The "Updated" line is still present.
      expect(find.textContaining('Updated'), findsOneWidget);
    });

    testWidgets('close button invokes onClose when wired', (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
            ),
            fetchedAt: _fetchedAt,
            onClose: () => calls++,
          ),
        ),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      expect(calls, 1);
    });
  });

  group('StationInfoSheet — observation grid', () {
    testWidgets('formats wind in mph with compass direction', (tester) async {
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
              // 5 m/s ≈ 11 mph, 90° = E.
              windSpeedMps: 5.0,
              windDirDegT: 90.0,
            ),
            fetchedAt: _fetchedAt,
          ),
        ),
      );
      expect(find.text('11 mph from E'), findsOneWidget);
    });

    testWidgets('appends gust when present', (tester) async {
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
              windSpeedMps: 5.0,
              windDirDegT: 0.0, // N
              gustMps: 8.0, // ≈ 18 mph
            ),
            fetchedAt: _fetchedAt,
          ),
        ),
      );
      expect(find.text('11 mph from N (gusts 18)'), findsOneWidget);
    });

    testWidgets('water + air temp render in F (with C in parens)',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
              waterTempC: 25.0, // 77°F
              airTempC: 22.0, // 72°F
            ),
            fetchedAt: _fetchedAt,
          ),
        ),
      );
      expect(find.text('77°F (25.0°C)'), findsOneWidget);
      expect(find.text('72°F (22.0°C)'), findsOneWidget);
    });

    testWidgets('waves render in feet with dominant period', (tester) async {
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
              waveHeightM: 1.0, // ≈ 3.3 ft
              dominantPeriodSec: 7.0,
            ),
            fetchedAt: _fetchedAt,
          ),
        ),
      );
      expect(find.text('3.3 ft @ 7s'), findsOneWidget);
    });

    testWidgets('pressure renders with hPa unit', (tester) async {
      await tester.pumpWidget(
        _harness(
          StationInfoSheet(
            station: _capeCanaveral,
            observation: BuoyObservation(
              stationId: _capeCanaveral.id,
              timestamp: _fetchedAt,
              pressureHpa: 1018.4,
            ),
            fetchedAt: _fetchedAt,
          ),
        ),
      );
      expect(find.text('1018.4 hPa'), findsOneWidget);
    });

    testWidgets(
      'missing fields render as a muted em-dash, not "0" or empty',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            StationInfoSheet(
              station: _capeCanaveral,
              observation: BuoyObservation(
                stationId: _capeCanaveral.id,
                timestamp: _fetchedAt,
                // every measurement null — buoy reported nothing on
                // the latest row (NDBC's 'MM' missing-value sentinel).
              ),
              fetchedAt: _fetchedAt,
            ),
          ),
        );
        // One em-dash per row — wind, water, air, waves, pressure = 5.
        expect(find.text('—'), findsNWidgets(5));
      },
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as ml;

import '../../core/types/lat_lng.dart';
import '../../data/sources/ndbc/buoy_station.dart';
import '../../state/component_providers.dart';
import '../../state/vessel_providers.dart';
import '../design/spacing.dart';
import '../picker/species_chip.dart';
import '../recommendation/recommendation_overlay.dart';
import '../recommendation/station_overlay.dart';
import 'marine_chart_view.dart';

/// Default initial camera target — Tampa Bay, FL.
///
/// The v1 species coverage is Florida inshore + offshore (snook, redfish,
/// tarpon, snapper, etc.) so the chart opens over the central west coast
/// where the calibration tuple was tuned. Replaced by user_preferences
/// home-waters once that lands in a later phase.
const _defaultCenter = ml.LatLng(27.94, -82.45);
const _defaultZoom = 9.0;

/// A tap within this many nautical miles of a station marker is
/// interpreted as a buoy tap (show station info), rather than an open-
/// water tap (show recommendation). 0.5 nm covers the marker footprint
/// at Phase-6 zooms plus typical fingertip slop without bleeding into
/// adjacent buoys (real FL stations are 5–30 nm apart).
const _buoyTapRadiusNm = 0.5;

class ChartViewScreen extends ConsumerStatefulWidget {
  const ChartViewScreen({super.key});

  @override
  ConsumerState<ChartViewScreen> createState() => _ChartViewScreenState();
}

class _ChartViewScreenState extends ConsumerState<ChartViewScreen> {
  /// Open-water tap that should drive the recommendation overlay.
  /// Mutually exclusive with [_selectedStation].
  LatLng? _tap;

  /// Buoy the user tapped that should drive the station info overlay.
  /// Mutually exclusive with [_tap].
  BuoyStation? _selectedStation;

  @override
  Widget build(BuildContext context) {
    final positionAsync = ref.watch(currentPositionProvider);
    final vesselMlPosition = positionAsync.maybeWhen(
      data: (p) => ml.LatLng(p.latitude, p.longitude),
      orElse: () => null,
    );
    final vesselCorePosition = vesselMlPosition == null
        ? null
        : LatLng(
            latitude: vesselMlPosition.latitude,
            longitude: vesselMlPosition.longitude,
          );

    final stationsAsync = ref.watch(ndbcStationsProvider);
    final stationPositions = stationsAsync.maybeWhen(
      data: (stations) => [
        for (final s in stations) ml.LatLng(s.lat, s.lon),
      ],
      orElse: () => const <ml.LatLng>[],
    );

    return Scaffold(
      body: Stack(
        children: [
          MarineChartView(
            initialCameraPosition: const ml.CameraPosition(
              target: _defaultCenter,
              zoom: _defaultZoom,
            ),
            vesselPosition: vesselMlPosition,
            stationPositions: stationPositions,
            onTap: _onChartTap,
          ),
          const SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                MarineSpacing.md + 2,
                MarineSpacing.md + 2,
                MarineSpacing.md + 2,
                0,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: SpeciesChip(),
              ),
            ),
          ),
          if (_selectedStation != null)
            StationOverlay(
              station: _selectedStation,
              vesselPosition: vesselCorePosition,
              onDismiss: () => setState(() => _selectedStation = null),
            )
          else
            RecommendationOverlay(
              tappedLocation: _tap,
              onDismiss: () => setState(() => _tap = null),
            ),
        ],
      ),
    );
  }

  void _onChartTap(ml.LatLng location) {
    final tap = LatLng(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    final station = _stationAt(tap);
    setState(() {
      if (station != null) {
        _selectedStation = station;
        _tap = null;
      } else {
        _tap = tap;
        _selectedStation = null;
      }
    });
  }

  /// Returns the loaded station whose location is within
  /// [_buoyTapRadiusNm] of [tap], or null when the tap landed on open
  /// water. Picks the nearest hit if multiple stations are within
  /// range — protects against overlapping markers at low zoom.
  BuoyStation? _stationAt(LatLng tap) {
    final stations = ref.read(ndbcStationsProvider).valueOrNull;
    if (stations == null || stations.isEmpty) return null;
    BuoyStation? best;
    var bestNm = _buoyTapRadiusNm;
    for (final s in stations) {
      final d = s.distanceNmTo(tap);
      if (d < bestNm) {
        best = s;
        bestNm = d;
      }
    }
    return best;
  }
}

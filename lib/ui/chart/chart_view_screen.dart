import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as ml;

import '../../core/types/lat_lng.dart';
import '../../data/sources/ndbc/buoy_station.dart';
import '../../data/sources/osm/boat_ramp_record.dart';
import '../../data/sources/osm/wreck_record.dart';
import '../../state/component_providers.dart';
import '../../state/osm_ramps_provider.dart';
import '../../state/osm_wrecks_provider.dart';
import '../../state/vessel_providers.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../picker/species_chip.dart';
import '../recommendation/boat_ramp_info_sheet.dart';
import '../recommendation/recommendation_overlay.dart';
import '../recommendation/station_overlay.dart';
import '../recommendation/wreck_info_sheet.dart';
import '../trip/plan_trip_screen.dart';
import 'marine_chart_view.dart';

/// Default initial camera target — Tampa Bay, FL.
///
/// The v1 species coverage is Florida inshore + offshore (snook, redfish,
/// tarpon, snapper, etc.) so the chart opens over the central west coast
/// where the calibration tuple was tuned. Replaced by user_preferences
/// home-waters once that lands in a later phase.
const _defaultCenter = ml.LatLng(27.94, -82.45);
const _defaultZoom = 9.0;

/// A tap within this many nautical miles of a buoy or wreck marker is
/// interpreted as a marker tap (show its info card), rather than an
/// open-water tap (show recommendation). 0.5 nm covers the marker
/// footprint at Phase-6 zooms plus typical fingertip slop without
/// bleeding into adjacent markers (real FL features are spaced miles
/// apart).
const _markerTapRadiusNm = 0.5;

/// Cap on the number of ramp markers rendered on the chart at once.
/// The bundled snapshot ships ~2150 ramps; rendering all of them as
/// maplibre Circle annotations is several minutes of native calls
/// (each `addCircle` is ~30-50 ms on Android emulator) and chokes
/// the app at startup. We pass the closest N to the user's vessel
/// (or chart centre when no GPS); the trip-planner picker keeps the
/// full list available for ramp selection.
const _maxRampMarkers = 150;

class ChartViewScreen extends ConsumerStatefulWidget {
  const ChartViewScreen({super.key});

  @override
  ConsumerState<ChartViewScreen> createState() => _ChartViewScreenState();
}

class _ChartViewScreenState extends ConsumerState<ChartViewScreen> {
  /// Open-water tap that should drive the recommendation overlay.
  /// Mutually exclusive with [_selectedStation], [_selectedWreck],
  /// and [_selectedRamp].
  LatLng? _tap;

  /// Buoy the user tapped that should drive the station info overlay.
  BuoyStation? _selectedStation;

  /// Wreck the user tapped that should drive the wreck info overlay.
  WreckRecord? _selectedWreck;

  /// Boat ramp the user tapped that should drive the ramp info
  /// overlay.
  BoatRampRecord? _selectedRamp;

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

    final wrecksAsync = ref.watch(osmWrecksProvider);
    final wreckPositions = wrecksAsync.maybeWhen(
      data: (wrecks) => [
        for (final w in wrecks) ml.LatLng(w.lat, w.lon),
      ],
      orElse: () => const <ml.LatLng>[],
    );

    final rampsAsync = ref.watch(osmRampsProvider);
    // Cap the rendered marker layer at the closest [_maxRampMarkers]
    // ramps to the user. Falls back to the chart's default centre
    // when no GPS fix is available.
    final rampOrigin = vesselCorePosition ??
        const LatLng(latitude: 27.94, longitude: -82.45);
    final rampPositions = rampsAsync.maybeWhen(
      data: (ramps) {
        final sorted = [...ramps]
          ..sort(
            (a, b) =>
                a.distanceNmTo(rampOrigin).compareTo(b.distanceNmTo(rampOrigin)),
          );
        return [
          for (final r in sorted.take(_maxRampMarkers))
            ml.LatLng(r.lat, r.lon),
        ];
      },
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
            wreckPositions: wreckPositions,
            rampPositions: rampPositions,
            onTap: _onChartTap,
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                MarineSpacing.md + 2,
                MarineSpacing.md + 2,
                MarineSpacing.md + 2,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpeciesChip(),
                  _PlanTripButton(onPressed: _openTripPlanner),
                ],
              ),
            ),
          ),
          _activeOverlay(vesselCorePosition),
        ],
      ),
    );
  }

  /// Mutually-exclusive overlay selector — ramp > wreck > station >
  /// tap > empty hint. Only one card surface is on screen at a time.
  Widget _activeOverlay(LatLng? vesselCorePosition) {
    final ramp = _selectedRamp;
    if (ramp != null) {
      return SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BoatRampInfoSheet(
            ramp: ramp,
            vesselPosition: vesselCorePosition,
            onClose: () => setState(() => _selectedRamp = null),
          ),
        ),
      );
    }
    final wreck = _selectedWreck;
    if (wreck != null) {
      return SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: WreckInfoSheet(
            wreck: wreck,
            vesselPosition: vesselCorePosition,
            onClose: () => setState(() => _selectedWreck = null),
          ),
        ),
      );
    }
    if (_selectedStation != null) {
      return StationOverlay(
        station: _selectedStation,
        vesselPosition: vesselCorePosition,
        onDismiss: () => setState(() => _selectedStation = null),
      );
    }
    return RecommendationOverlay(
      tappedLocation: _tap,
      onDismiss: () => setState(() => _tap = null),
    );
  }

  void _onChartTap(ml.LatLng location) {
    final tap = LatLng(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    // Resolution priority: ramp → wreck → buoy → open water. Ramps
    // win ties because they're the rarest tap intent (user wants to
    // plan a trip from THIS ramp specifically). All marker layers
    // use the same tap radius; in practice they sit at distinct
    // lat/lons so ties are vanishingly rare.
    final ramp = _rampAt(tap);
    if (ramp != null) {
      setState(() {
        _selectedRamp = ramp;
        _selectedWreck = null;
        _selectedStation = null;
        _tap = null;
      });
      return;
    }
    final wreck = _wreckAt(tap);
    if (wreck != null) {
      setState(() {
        _selectedRamp = null;
        _selectedWreck = wreck;
        _selectedStation = null;
        _tap = null;
      });
      return;
    }
    final station = _stationAt(tap);
    setState(() {
      _selectedRamp = null;
      if (station != null) {
        _selectedStation = station;
        _selectedWreck = null;
        _tap = null;
      } else {
        _tap = tap;
        _selectedStation = null;
        _selectedWreck = null;
      }
    });
  }

  Future<void> _openTripPlanner() async {
    await Navigator.of(context).push<String?>(
      MaterialPageRoute(builder: (_) => const PlanTripScreen()),
    );
  }

  /// Returns the loaded station whose location is within
  /// [_markerTapRadiusNm] of [tap], or null when the tap landed on
  /// open water. Picks the nearest hit if multiple stations are within
  /// range — protects against overlapping markers at low zoom.
  BuoyStation? _stationAt(LatLng tap) {
    final stations = ref.read(ndbcStationsProvider).valueOrNull;
    if (stations == null || stations.isEmpty) return null;
    BuoyStation? best;
    var bestNm = _markerTapRadiusNm;
    for (final s in stations) {
      final d = s.distanceNmTo(tap);
      if (d < bestNm) {
        best = s;
        bestNm = d;
      }
    }
    return best;
  }

  /// Mirror of [_stationAt] for the wreck layer.
  WreckRecord? _wreckAt(LatLng tap) {
    final wrecks = ref.read(osmWrecksProvider).valueOrNull;
    if (wrecks == null || wrecks.isEmpty) return null;
    WreckRecord? best;
    var bestNm = _markerTapRadiusNm;
    for (final w in wrecks) {
      final d = w.distanceNmTo(tap);
      if (d < bestNm) {
        best = w;
        bestNm = d;
      }
    }
    return best;
  }

  /// Mirror of [_stationAt] for the boat-ramp layer.
  BoatRampRecord? _rampAt(LatLng tap) {
    final ramps = ref.read(osmRampsProvider).valueOrNull;
    if (ramps == null || ramps.isEmpty) return null;
    BoatRampRecord? best;
    var bestNm = _markerTapRadiusNm;
    for (final r in ramps) {
      final d = r.distanceNmTo(tap);
      if (d < bestNm) {
        best = r;
        bestNm = d;
      }
    }
    return best;
  }
}

/// Top-right pill that opens [PlanTripScreen]. Same chrome as the
/// species chip on the left so the two top affordances read as a
/// matched pair.
class _PlanTripButton extends StatelessWidget {
  const _PlanTripButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MarineSpacing.md + 2,
            vertical: MarineSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: MarineColors.surfaceElevated,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: MarineColors.divider),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_road,
                size: 16,
                color: MarineColors.onDark,
              ),
              SizedBox(width: MarineSpacing.xs + 2),
              Text(
                'Plan trip',
                style: TextStyle(
                  color: MarineColors.onDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

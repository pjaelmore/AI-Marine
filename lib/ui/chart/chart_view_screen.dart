import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as ml;

import '../../core/types/lat_lng.dart';
import '../../data/sources/ndbc/buoy_station.dart';
import '../../data/sources/osm/wreck_record.dart';
import '../../state/component_providers.dart';
import '../../state/engine_providers.dart';
import '../../state/osm_wrecks_provider.dart';
import '../../state/vessel_providers.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../picker/species_chip.dart';
import '../recommendation/recommendation_overlay.dart';
import '../recommendation/station_overlay.dart';
import '../recommendation/wreck_info_sheet.dart';
import '../trip/plan_trip_screen.dart';
import 'heatmap_palette.dart';
import 'marine_chart_view.dart';

/// Default initial camera target — Cape Canaveral, FL.
///
/// Opens slightly offshore (~10 nm east of the cape) so both the coast
/// and the offshore NDBC ring (41009 Canaveral 20NM East, 41010, etc.)
/// are visible at zoom 9. The v1 species coverage is Florida saltwater
/// generally; the user_preferences home-waters override lands in a
/// later phase.
const _defaultCenter = ml.LatLng(28.4, -80.4);
const _defaultZoom = 9.0;

/// A tap within this many nautical miles of a buoy or wreck marker is
/// interpreted as a marker tap (show its info card), rather than an
/// open-water tap (show recommendation). 0.5 nm covers the marker
/// footprint at Phase-6 zooms plus typical fingertip slop without
/// bleeding into adjacent markers (real FL features are spaced miles
/// apart).
const _markerTapRadiusNm = 0.5;

/// Heatmap-grid resolution in nautical miles. 8 nm at zoom 9 gives
/// roughly 25–50 cells across the visible viewport — coarse enough
/// to render quickly with cold caches (~10 s on first paint), fine
/// enough to surface where the score peaks are. Tightenable to the
/// Phase-6 0.6 nm target once the score grid is cached offline by
/// the slice 13b–d tile / score pre-fetch.
const _heatmapResolutionNm = 8.0;

class ChartViewScreen extends ConsumerStatefulWidget {
  const ChartViewScreen({super.key});

  @override
  ConsumerState<ChartViewScreen> createState() => _ChartViewScreenState();
}

class _ChartViewScreenState extends ConsumerState<ChartViewScreen> {
  /// Open-water tap that should drive the recommendation overlay.
  /// Mutually exclusive with [_selectedStation] and [_selectedWreck].
  LatLng? _tap;

  /// Buoy the user tapped that should drive the station info overlay.
  BuoyStation? _selectedStation;

  /// Wreck the user tapped that should drive the wreck info overlay.
  WreckRecord? _selectedWreck;

  /// Latest viewport bounds reported by [MarineChartView]'s
  /// `onCameraIdle`. Drives the heatmap grid lookup. Null until the
  /// chart's first idle event after style load.
  LatLngBounds? _viewportBounds;

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

    final heatmapCells = _watchHeatmapCells(ref);

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
            heatmapCells: heatmapCells,
            onTap: _onChartTap,
            onCameraIdle: _onCameraIdle,
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

  /// Mutually-exclusive overlay selector — wreck > station > tap >
  /// empty hint. Only one card surface is on screen at a time.
  Widget _activeOverlay(LatLng? vesselCorePosition) {
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
    // Resolution priority: wreck → buoy → open water. Markers use the
    // same tap radius; in practice they sit at distinct lat/lons so
    // ties are vanishingly rare.
    final wreck = _wreckAt(tap);
    if (wreck != null) {
      setState(() {
        _selectedWreck = wreck;
        _selectedStation = null;
        _tap = null;
      });
      return;
    }
    final station = _stationAt(tap);
    setState(() {
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

  /// MapLibreMap reports the camera has settled. Capture the visible
  /// bounds in state so the heatmap-grid lookup keys against them.
  void _onCameraIdle(ml.LatLngBounds bounds) {
    final core = LatLngBounds(
      southwest: LatLng(
        latitude: bounds.southwest.latitude,
        longitude: bounds.southwest.longitude,
      ),
      northeast: LatLng(
        latitude: bounds.northeast.latitude,
        longitude: bounds.northeast.longitude,
      ),
    );
    if (_viewportBounds == core) return;
    setState(() => _viewportBounds = core);
  }

  /// Watches [scoreGridProvider] for the current viewport + species +
  /// time, and converts the resulting [ScoreResult] list into heatmap
  /// cells via [buildHeatmapCells]. Empty list while bounds are
  /// unknown or the grid is loading / errored — the chart just shows
  /// no overlay until cells resolve.
  List<HeatmapCellSpec> _watchHeatmapCells(WidgetRef ref) {
    final bounds = _viewportBounds;
    if (bounds == null) return const [];
    final speciesId = ref.watch(selectedSpeciesIdProvider);
    final time = ref.watch(selectedTimeProvider);
    final query = (
      speciesId: speciesId,
      bbox: bounds,
      time: time,
      resolutionNm: _heatmapResolutionNm,
    );
    final gridAsync = ref.watch(scoreGridProvider(query));
    return gridAsync.maybeWhen(
      data: (grid) => buildHeatmapCells(grid, _heatmapResolutionNm),
      orElse: () => const [],
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

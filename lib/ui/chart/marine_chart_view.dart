import 'dart:async';
import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// Renders the active marine chart style inside a [MapLibreMap], plus an
/// optional vessel-position dot and station markers.
///
/// The TDD §5.5.2 NOAA ENC tile endpoint was retired (see
/// docs/adr/0002-chart-tile-source.md) and NOAA's public RNC tile service
/// followed in Jan 2025. Phase 6 swapped to **Esri World Ocean Base** as
/// the basemap with **OpenSeaMap** overlaid for channel markers + lights —
/// gives an ocean-styled map with bathymetry shading without depending on
/// NOAA infrastructure that's been intermittently unreachable. NOAA
/// MBTiles bundling for true chartplotter-equivalent offline charts is
/// scoped for v1.5+.
class MarineChartView extends StatefulWidget {
  const MarineChartView({
    super.key,
    required this.initialCameraPosition,
    this.vesselPosition,
    this.stationPositions = const <LatLng>[],
    this.wreckPositions = const <LatLng>[],
    this.heatmapCells = const <HeatmapCellSpec>[],
    this.onTap,
    this.onCameraIdle,
    this.styleAssetPath = _defaultStyleAsset,
  });

  static const _defaultStyleAsset = 'assets/map_styles/marine_chart_dev.json';

  final CameraPosition initialCameraPosition;

  /// Current vessel position. When non-null, a teal dot is drawn at this
  /// location and the camera follows on subsequent updates.
  final LatLng? vesselPosition;

  /// NDBC buoy / coastal-station positions to render as small chart-
  /// style markers (white pip with a deep-marine outline). Empty by
  /// default; the chart shell passes the loaded list once
  /// [ndbcStationsProvider] resolves. Distinct from the vessel dot so
  /// the user can tell their boat from a buoy at a glance.
  final List<LatLng> stationPositions;

  /// OSM-derived wreck positions to render as warn-amber markers,
  /// visually distinct from buoys so the user can tell structure from
  /// data station at a glance. Empty by default; the chart shell
  /// passes the loaded list once [osmWrecksProvider] resolves.
  final List<LatLng> wreckPositions;

  /// Heatmap cells to render as coloured semi-transparent squares.
  /// Each cell carries its centre, half-side in degrees, and fill
  /// colour from the score → palette mapping. The chart shell
  /// rebuilds this list when the viewport, species, or time change.
  final List<HeatmapCellSpec> heatmapCells;

  /// Invoked when the user taps a spot on the chart. The chart shell
  /// uses this to drive the recommendation overlay — the tapped LatLng
  /// becomes the score query's location. Heatmap-cell taps also flow
  /// through this callback with the tapped cell's centre as location.
  final void Function(LatLng location)? onTap;

  /// Invoked when the camera settles after panning / zooming. The
  /// chart shell uses this to refresh the heatmap grid for the new
  /// viewport bounds.
  final void Function(LatLngBounds bounds)? onCameraIdle;

  final String styleAssetPath;

  @override
  State<MarineChartView> createState() => _MarineChartViewState();
}

class _MarineChartViewState extends State<MarineChartView> {
  // Vessel-dot styling — mirrors MarineColors.actionTeal (#0F6E56) and white.
  static const _vesselFillHex = '#0F6E56';
  static const _vesselStrokeHex = '#FFFFFF';
  static const _vesselRadiusPx = 10.0;
  static const _vesselStrokeWidthPx = 2.0;

  // Station-marker styling — small white pip with deep-marine outline,
  // visually quiet so dozens of buoys don't compete with the vessel
  // dot or the chart features beneath them.
  static const _stationFillHex = '#FFFFFF';
  static const _stationStrokeHex = '#0F2A47';
  static const _stationRadiusPx = 5.0;
  static const _stationStrokeWidthPx = 1.5;

  // Wreck-marker styling — warn-amber fill (MarineColors.warnAmber
  // #E89F3C) with a dark outline. Amber distinguishes structure from
  // the white buoy pips and from the teal vessel dot, and matches the
  // chart-symbology convention of warm colours for hazards.
  static const _wreckFillHex = '#E89F3C';
  static const _wreckStrokeHex = '#0F2A47';
  static const _wreckRadiusPx = 6.0;
  static const _wreckStrokeWidthPx = 1.5;

  String? _styleJson;
  Object? _loadError;
  MapLibreMapController? _controller;
  bool _styleLoaded = false;
  Circle? _vesselCircle;
  final List<Circle> _stationCircles = [];
  List<LatLng> _renderedStationPositions = const [];
  final List<Circle> _wreckCircles = [];
  List<LatLng> _renderedWreckPositions = const [];
  final List<Fill> _heatmapFills = [];
  List<HeatmapCellSpec> _renderedHeatmapCells = const [];

  /// Tracks whether the camera has already centered on the user's
  /// first GPS fix. Set once the initial vessel position lands so
  /// subsequent fixes (the user moves) don't keep yanking the camera
  /// back — after the first follow, the user controls the view.
  bool _hasFollowedFirstFix = false;

  @override
  void initState() {
    super.initState();
    unawaited(_loadStyle());
  }

  Future<void> _loadStyle() async {
    try {
      final json = await rootBundle.loadString(widget.styleAssetPath);
      if (mounted) setState(() => _styleJson = json);
    } catch (e) {
      if (mounted) setState(() => _loadError = e);
    }
  }

  void _onMapCreated(MapLibreMapController controller) {
    _controller = controller;
    // maplibre's Circle / Fill annotations consume tap events
    // themselves — they don't bubble through to `onMapClick`.
    // Subscribe to the separate per-annotation channels and forward
    // any tapped geometry to widget.onTap so the chart shell sees
    // marker + heatmap taps the same way it sees open-water taps.
    controller.onCircleTapped.add(_handleCircleTap);
    controller.onFillTapped.add(_handleFillTap);
  }

  /// MapLibreMap's `onCameraIdle` callback. Pulls the current visible
  /// region from the controller and fires the widget callback so the
  /// chart shell can refresh viewport-keyed providers (heatmap grid).
  Future<void> _handleCameraIdle() async {
    final controller = _controller;
    if (controller == null) return;
    try {
      final bounds = await controller.getVisibleRegion();
      widget.onCameraIdle?.call(bounds);
    } catch (_) {
      // Native plugin can throw mid-shutdown; swallow rather than
      // surfacing a spurious crash.
    }
  }

  void _onStyleLoaded() {
    _styleLoaded = true;
    // Defend against the maplibre quirk where the loaded style's own
    // default center can override `initialCameraPosition` on first
    // paint. Re-issue the move once the style is up so the user lands
    // on the configured target every time.
    final controller = _controller;
    if (controller != null) {
      unawaited(
        controller.moveCamera(
          CameraUpdate.newCameraPosition(widget.initialCameraPosition),
        ),
      );
    }
    unawaited(_syncVesselMarker());
    unawaited(_syncStationMarkers());
    unawaited(_syncWreckMarkers());
    unawaited(_syncHeatmapCells());
    // Fire an initial bounds callback so the heatmap-grid provider
    // has a viewport to score against without waiting for the user
    // to pan.
    unawaited(_handleCameraIdle());
  }

  @override
  void didUpdateWidget(covariant MarineChartView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.vesselPosition != oldWidget.vesselPosition) {
      unawaited(_syncVesselMarker());
    }
    if (!_listEquals(widget.stationPositions, oldWidget.stationPositions)) {
      unawaited(_syncStationMarkers());
    }
    if (!_listEquals(widget.wreckPositions, oldWidget.wreckPositions)) {
      unawaited(_syncWreckMarkers());
    }
    if (!_heatmapCellsEqual(widget.heatmapCells, oldWidget.heatmapCells)) {
      unawaited(_syncHeatmapCells());
    }
  }

  bool _listEquals(List<LatLng> a, List<LatLng> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  bool _heatmapCellsEqual(List<HeatmapCellSpec> a, List<HeatmapCellSpec> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<void> _syncVesselMarker() async {
    final controller = _controller;
    if (controller == null || !_styleLoaded) return;
    final pos = widget.vesselPosition;
    if (pos == null) {
      if (_vesselCircle != null) {
        await controller.removeCircle(_vesselCircle!);
        _vesselCircle = null;
      }
      return;
    }
    if (!_hasFollowedFirstFix) {
      _hasFollowedFirstFix = true;
      unawaited(
        controller.animateCamera(CameraUpdate.newLatLng(pos)),
      );
    }
    if (_vesselCircle == null) {
      _vesselCircle = await controller.addCircle(
        const CircleOptions(
          circleColor: _vesselFillHex,
          circleRadius: _vesselRadiusPx,
          circleStrokeColor: _vesselStrokeHex,
          circleStrokeWidth: _vesselStrokeWidthPx,
        ).copyWith(CircleOptions(geometry: pos)),
      );
    } else {
      await controller.updateCircle(
        _vesselCircle!,
        CircleOptions(geometry: pos),
      );
    }
  }

  /// Replaces the existing station-marker layer with one circle per
  /// position in [MarineChartView.stationPositions]. Doing a full
  /// remove-and-add on each change keeps the diff trivial; the list
  /// only updates on app start (when the bundled snapshot loads) so
  /// the cost is negligible.
  Future<void> _syncStationMarkers() async {
    final controller = _controller;
    if (controller == null || !_styleLoaded) return;
    if (_listEquals(widget.stationPositions, _renderedStationPositions)) return;
    for (final c in _stationCircles) {
      await controller.removeCircle(c);
    }
    _stationCircles.clear();
    for (final pos in widget.stationPositions) {
      final circle = await controller.addCircle(
        const CircleOptions(
          circleColor: _stationFillHex,
          circleRadius: _stationRadiusPx,
          circleStrokeColor: _stationStrokeHex,
          circleStrokeWidth: _stationStrokeWidthPx,
        ).copyWith(CircleOptions(geometry: pos)),
      );
      _stationCircles.add(circle);
    }
    _renderedStationPositions = List.unmodifiable(widget.stationPositions);
  }

  /// Same shape as [_syncStationMarkers] for the wreck layer — full
  /// remove-and-add when the input list changes. The wreck snapshot
  /// only loads once at startup so the cost is negligible; if we ever
  /// switch to live trip-area filtering, swap to a diff.
  Future<void> _syncWreckMarkers() async {
    final controller = _controller;
    if (controller == null || !_styleLoaded) return;
    if (_listEquals(widget.wreckPositions, _renderedWreckPositions)) return;
    for (final c in _wreckCircles) {
      await controller.removeCircle(c);
    }
    _wreckCircles.clear();
    for (final pos in widget.wreckPositions) {
      final circle = await controller.addCircle(
        const CircleOptions(
          circleColor: _wreckFillHex,
          circleRadius: _wreckRadiusPx,
          circleStrokeColor: _wreckStrokeHex,
          circleStrokeWidth: _wreckStrokeWidthPx,
        ).copyWith(CircleOptions(geometry: pos)),
      );
      _wreckCircles.add(circle);
    }
    _renderedWreckPositions = List.unmodifiable(widget.wreckPositions);
  }

  /// Replaces the heatmap fill layer with one polygon per cell spec.
  /// Each cell is a small square axis-aligned to lat/lon (good enough
  /// for chart density at FL latitudes; we're not drawing fault lines).
  Future<void> _syncHeatmapCells() async {
    final controller = _controller;
    if (controller == null || !_styleLoaded) return;
    if (_heatmapCellsEqual(widget.heatmapCells, _renderedHeatmapCells)) return;
    for (final f in _heatmapFills) {
      await controller.removeFill(f);
    }
    _heatmapFills.clear();
    for (final cell in widget.heatmapCells) {
      final dLat = cell.halfSideDegLat;
      final dLon = cell.halfSideDegLon;
      final ring = [
        LatLng(cell.center.latitude - dLat, cell.center.longitude - dLon),
        LatLng(cell.center.latitude - dLat, cell.center.longitude + dLon),
        LatLng(cell.center.latitude + dLat, cell.center.longitude + dLon),
        LatLng(cell.center.latitude + dLat, cell.center.longitude - dLon),
        LatLng(cell.center.latitude - dLat, cell.center.longitude - dLon),
      ];
      final fill = await controller.addFill(
        FillOptions(
          geometry: [ring],
          fillColor: cell.fillColorHex,
          fillOpacity: cell.fillOpacity,
          fillOutlineColor: cell.fillColorHex,
        ),
      );
      _heatmapFills.add(fill);
    }
    _renderedHeatmapCells = List.unmodifiable(widget.heatmapCells);
  }

  @override
  Widget build(BuildContext context) {
    if (_loadError != null) {
      return Center(
        child: Text(
          'Could not load chart style: $_loadError',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    if (_styleJson == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return MapLibreMap(
      styleString: _styleJson!,
      initialCameraPosition: widget.initialCameraPosition,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoaded,
      onMapClick: _handleTap,
      onCameraIdle: _handleCameraIdle,
    );
  }

  void _handleTap(Point<double> _, LatLng location) {
    widget.onTap?.call(location);
  }

  /// Forward taps on station circles to the same callback the open-
  /// water tap path uses, so the chart shell's `_stationAt` lookup
  /// resolves to the buoy. Skips the vessel circle — the user
  /// shouldn't get a station card by tapping their own boat.
  void _handleCircleTap(Circle circle) {
    if (identical(circle, _vesselCircle)) return;
    final geometry = circle.options.geometry;
    if (geometry == null) return;
    widget.onTap?.call(geometry);
  }

  /// Forward taps on heatmap fill cells to the chart-tap callback with
  /// the cell's centre as the tap location. The chart shell renders
  /// the recommendation card for that centre, which is also the
  /// location the score grid evaluated.
  void _handleFillTap(Fill fill) {
    // Find the matching cell spec to recover the centre — fillOptions
    // doesn't carry the centre directly, so we lean on positional
    // correspondence between [_heatmapFills] and [_renderedHeatmapCells].
    final idx = _heatmapFills.indexOf(fill);
    if (idx < 0 || idx >= _renderedHeatmapCells.length) return;
    widget.onTap?.call(_renderedHeatmapCells[idx].center);
  }
}

/// One heatmap cell — a small square centred on [center] with the
/// supplied half-extents in degrees and fill colour. The chart shell
/// builds these from the [scoreGridProvider] response by mapping each
/// [ScoreResult] to a colour via [MarineColors.heatmap*] stops.
class HeatmapCellSpec {
  const HeatmapCellSpec({
    required this.center,
    required this.halfSideDegLat,
    required this.halfSideDegLon,
    required this.fillColorHex,
    required this.fillOpacity,
  });

  final LatLng center;
  final double halfSideDegLat;
  final double halfSideDegLon;
  final String fillColorHex;
  final double fillOpacity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HeatmapCellSpec &&
        other.center == center &&
        other.halfSideDegLat == halfSideDegLat &&
        other.halfSideDegLon == halfSideDegLon &&
        other.fillColorHex == fillColorHex &&
        other.fillOpacity == fillOpacity;
  }

  @override
  int get hashCode => Object.hash(
        center,
        halfSideDegLat,
        halfSideDegLon,
        fillColorHex,
        fillOpacity,
      );
}

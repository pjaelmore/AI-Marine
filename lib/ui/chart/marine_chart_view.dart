import 'dart:async';
import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// Renders the active marine chart style inside a [MapLibreMap], plus an
/// optional vessel-position dot.
///
/// The TDD §5.5.2 NOAA ENC tile endpoint was retired by NOAA in October 2021
/// (see docs/adr/0002-chart-tile-source.md); for Phase 1–3 the dev style
/// uses OpenStreetMap + OpenSeaMap to render a real nautical chart while
/// MBTiles support is built into the cache layer in Phase 4.
///
/// Phase 1 scope: chart tiles + vessel dot. The heatmap, recommendation pins,
/// and overlay chrome (species picker, time / mode indicators, log-catch FAB)
/// are added in subsequent phases per Implementation Guide §1.2.
class MarineChartView extends StatefulWidget {
  const MarineChartView({
    super.key,
    required this.initialCameraPosition,
    this.vesselPosition,
    this.stationPositions = const <LatLng>[],
    this.onTap,
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

  /// Invoked when the user taps a spot on the chart. The chart shell
  /// uses this to drive the recommendation overlay — the tapped LatLng
  /// becomes the score query's location.
  final void Function(LatLng location)? onTap;

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

  String? _styleJson;
  Object? _loadError;
  MapLibreMapController? _controller;
  bool _styleLoaded = false;
  Circle? _vesselCircle;
  final List<Circle> _stationCircles = [];
  List<LatLng> _renderedStationPositions = const [];

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
    // maplibre's Circle annotations consume tap events themselves —
    // they don't bubble through to `onMapClick`. Subscribe to the
    // separate per-circle channel and forward station-circle taps as
    // chart taps so the buoy-tap routing in the chart shell sees them.
    controller.onCircleTapped.add(_handleCircleTap);
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
  }

  bool _listEquals(List<LatLng> a, List<LatLng> b) {
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
}

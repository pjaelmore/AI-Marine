import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as ml;

import '../../core/types/lat_lng.dart';
import '../../state/vessel_providers.dart';
import '../recommendation/recommendation_overlay.dart';
import 'marine_chart_view.dart';

/// Default initial camera target — Boston Harbor.
///
/// Matches the TDD §6.8 worked-example coordinate so the Phase 1 deliverable
/// (Implementation Guide §2.2.3, "shows your boat ramp on a NOAA chart") has
/// a sensible starting view that sits inside the v1 striper range. Replaced
/// by user_preferences home-waters when that lands in Phase 2.
const _defaultCenter = ml.LatLng(42.36, -70.55);
const _defaultZoom = 10.0;

class ChartViewScreen extends ConsumerStatefulWidget {
  const ChartViewScreen({super.key});

  @override
  ConsumerState<ChartViewScreen> createState() => _ChartViewScreenState();
}

class _ChartViewScreenState extends ConsumerState<ChartViewScreen> {
  /// Last spot the user tapped, in the app's canonical [LatLng]. Null
  /// before the first tap (or after the user dismisses the card).
  /// Drives the recommendation overlay's state machine.
  LatLng? _tap;

  @override
  Widget build(BuildContext context) {
    final positionAsync = ref.watch(currentPositionProvider);
    final vesselPosition = positionAsync.maybeWhen(
      data: (p) => ml.LatLng(p.latitude, p.longitude),
      orElse: () => null,
    );

    return Scaffold(
      body: Stack(
        children: [
          MarineChartView(
            initialCameraPosition: const ml.CameraPosition(
              target: _defaultCenter,
              zoom: _defaultZoom,
            ),
            vesselPosition: vesselPosition,
            onTap: _onChartTap,
          ),
          RecommendationOverlay(
            tappedLocation: _tap,
            onDismiss: () => setState(() => _tap = null),
          ),
        ],
      ),
    );
  }

  void _onChartTap(ml.LatLng location) {
    setState(() {
      _tap = LatLng(
        latitude: location.latitude,
        longitude: location.longitude,
      );
    });
  }
}

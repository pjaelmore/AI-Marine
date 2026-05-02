import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../state/vessel_providers.dart';
import 'marine_chart_view.dart';

/// Default initial camera target — Boston Harbor.
///
/// Matches the TDD §6.8 worked-example coordinate so the Phase 1 deliverable
/// (Implementation Guide §2.2.3, "shows your boat ramp on a NOAA chart") has
/// a sensible starting view that sits inside the v1 striper range. Replaced
/// by user_preferences home-waters when that lands in Phase 2.
const _defaultCenter = LatLng(42.36, -70.55);
const _defaultZoom = 10.0;

class ChartViewScreen extends ConsumerWidget {
  const ChartViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(currentPositionProvider);
    final vesselPosition = positionAsync.maybeWhen(
      data: (p) => LatLng(p.latitude, p.longitude),
      orElse: () => null,
    );
    return Scaffold(
      body: MarineChartView(
        initialCameraPosition: const CameraPosition(
          target: _defaultCenter,
          zoom: _defaultZoom,
        ),
        vesselPosition: vesselPosition,
      ),
    );
  }
}

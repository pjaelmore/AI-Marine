import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/types/lat_lng.dart';
import '../../data/sources/ndbc/buoy_station.dart';
import '../../state/station_observation_providers.dart';
import 'recommendation_error_sheet.dart';
import 'recommendation_loading_sheet.dart';
import 'station_info_sheet.dart';

/// Bottom-aligned overlay that swaps between the station info card and
/// its loading / error siblings based on
/// [stationObservationProvider]'s [AsyncValue]. Mirrors the structure
/// of [RecommendationOverlay] so the two surfaces feel like the same
/// family — same chrome, same loading copy, same dismiss flow.
///
/// Returns nothing when [station] is null so the chart shell can keep
/// the recommendation overlay (or the empty hint) in place when no
/// buoy is selected.
class StationOverlay extends ConsumerWidget {
  const StationOverlay({
    super.key,
    required this.station,
    required this.vesselPosition,
    required this.onDismiss,
  });

  /// The buoy the user tapped, or null if they tapped open water.
  final BuoyStation? station;

  /// Vessel position threaded through to the info card so it can show
  /// "X nm from your vessel". Null when there's no GPS fix yet.
  final LatLng? vesselPosition;

  /// Invoked when the user taps the close button on the info card.
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = station;
    if (s == null) return const SizedBox.shrink();

    final obsAsync = ref.watch(stationObservationProvider(s));
    return obsAsync.when(
      loading: () => const _BottomAligned(child: RecommendationLoadingSheet()),
      error: (e, _) => _BottomAligned(
        child: RecommendationErrorSheet(
          message: _userFacingMessage(e),
          onRetry: () => ref.invalidate(stationObservationProvider(s)),
        ),
      ),
      data: (result) => _BottomAligned(
        child: StationInfoSheet(
          station: s,
          observation: result.value,
          fetchedAt: result.fetchedAt,
          vesselPosition: vesselPosition,
          onClose: onDismiss,
        ),
      ),
    );
  }
}

class _BottomAligned extends StatelessWidget {
  const _BottomAligned({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: child,
      ),
    );
  }
}

/// Strip the conventional Dart exception-class prefix off the front of
/// a stringified throwable so the error sheet leads with the message
/// the source threw, not "Exception: ".
String _userFacingMessage(Object e) {
  final raw = e.toString();
  final colonIdx = raw.indexOf(': ');
  if (colonIdx > 0 && colonIdx < 32) {
    return raw.substring(colonIdx + 2);
  }
  return raw;
}

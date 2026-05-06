import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/types/lat_lng.dart';
import '../../state/engine_providers.dart';
import 'recommendation_card_sheet.dart';
import 'recommendation_empty_sheet.dart';
import 'recommendation_error_sheet.dart';
import 'recommendation_loading_sheet.dart';

/// Bottom-aligned overlay that swaps between the recommendation card
/// and its loading / error / empty siblings based on the score
/// provider's [AsyncValue] state.
///
/// Decoupled from the chart so it can be widget-tested without the
/// MapLibre platform plumbing — a parent passes in the user's tapped
/// location (or null for the pre-tap empty state) plus a dismiss
/// callback, and the overlay watches [scoreAtLocationProvider] keyed
/// by `(selectedSpeciesId, tappedLocation, selectedTime)`.
class RecommendationOverlay extends ConsumerWidget {
  const RecommendationOverlay({
    super.key,
    required this.tappedLocation,
    required this.onDismiss,
  });

  /// The user's currently tapped chart location, or null if no spot
  /// has been tapped yet (or the user dismissed the last card).
  final LatLng? tappedLocation;

  /// Invoked when the user taps the close button on the recommendation
  /// card. The chart shell uses this to clear [tappedLocation] so the
  /// overlay falls back to the empty sheet.
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tap = tappedLocation;
    if (tap == null) {
      return const _BottomAligned(child: RecommendationEmptySheet());
    }

    final speciesId = ref.watch(selectedSpeciesIdProvider);
    final time = ref.watch(selectedTimeProvider);
    final query = (
      speciesId: speciesId,
      location: tap,
      time: time,
    );
    final scoreAsync = ref.watch(scoreAtLocationProvider(query));

    return scoreAsync.when(
      loading: () => const _BottomAligned(child: RecommendationLoadingSheet()),
      error: (e, _) => _BottomAligned(
        child: RecommendationErrorSheet(
          message: _userFacingMessage(e),
          onRetry: () => ref.invalidate(scoreAtLocationProvider(query)),
        ),
      ),
      // The card sheet uses DraggableScrollableSheet which positions
      // itself; SafeArea would clip its peek/expanded heights, so it
      // gets the raw Stack child slot.
      data: (result) => RecommendationCardSheet(
        result: result,
        onClose: onDismiss,
      ),
    );
  }
}

/// Bottom-aligned + bottom-safe-area wrapper for the static state
/// sheets (loading / error / empty). Keeps them above the Android
/// gesture nav pill / iOS home indicator. Skip for the real
/// [RecommendationCardSheet] which manages its own positioning via
/// [DraggableScrollableSheet].
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

/// Maps a thrown object to a short, human-readable message suitable
/// for the error sheet. Stringifies anything we don't recognise — v1
/// keeps this minimal; the calculator + conditions service throw
/// fairly self-describing errors and we can refine the mapping when
/// real failure modes shake out in the field.
String _userFacingMessage(Object e) {
  final raw = e.toString();
  // Strip the conventional "Exception: " / "FormatException: " prefix
  // so the error sheet doesn't lead with a Dart implementation noun.
  final colonIdx = raw.indexOf(': ');
  if (colonIdx > 0 && colonIdx < 32) {
    return raw.substring(colonIdx + 2);
  }
  return raw;
}

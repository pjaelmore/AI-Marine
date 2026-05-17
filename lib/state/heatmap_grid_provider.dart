import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/types/lat_lng.dart';
import '../core/types/score_result.dart';
import 'engine_providers.dart';

/// Family-key shape for [heatmapGridProvider]. Same fields as
/// [scoreGridProvider]'s `GridQuery` but kept separate so the two
/// providers don't share cache identity — the heatmap is allowed to
/// fail individual cells without invalidating the cache used by the
/// score-at-location path.
typedef HeatmapGridQuery = ({
  String speciesId,
  LatLngBounds bbox,
  DateTime time,
  double resolutionNm,
});

/// Resilient version of [scoreGridProvider] for the chart heatmap.
///
/// The calculator's `scoreGrid` is sequential and throws on the first
/// failed cell — a single unreachable NDBC fetch tanks the entire
/// grid. That's fine for batch scoring (the catch-all error is
/// visible) but wrong for a passive visualisation: anglers should
/// see whatever cells succeeded, not a blank chart when one tile of
/// the score grid couldn't reach a data source.
///
/// We bypass `scoreGrid` and fan out per cell via [scoreAtLocationProvider],
/// which already wraps its result in `AsyncValue`. Failed cells are
/// silently skipped; successful cells render. The cells are scored
/// in parallel batches of 4 to spread network load without saturating.
final heatmapGridProvider = FutureProvider.autoDispose
    .family<List<ScoreResult>, HeatmapGridQuery>((ref, query) async {
  final centres = _gridCentres(query.bbox, query.resolutionNm);
  final results = <ScoreResult>[];
  // Score in parallel batches so 30+ cells don't serialise behind
  // the NDBC adapter's single-request bottleneck. The conditions
  // service has internal caching, so adjacent cells share state.
  const batchSize = 4;
  for (var i = 0; i < centres.length; i += batchSize) {
    final batch = centres.skip(i).take(batchSize);
    final scored = await Future.wait(
      batch.map((centre) async {
        try {
          return await ref.read(
            scoreAtLocationProvider(
              (
                speciesId: query.speciesId,
                location: centre,
                time: query.time,
              ),
            ).future,
          );
        } catch (_) {
          // Per-cell failures (e.g., one NDBC station unreachable)
          // shouldn't blank the whole heatmap. Skip and move on.
          return null;
        }
      }),
    );
    for (final r in scored) {
      if (r != null) results.add(r);
    }
  }
  return results;
});

/// Generates the centre coordinate of each cell in the bbox at the
/// supplied resolution. Mirrors the calculator's `scoreGrid` row /
/// column math — cell centres are at `(0.5 + i)` of each step so the
/// renderer's square overlays line up with the score samples.
List<LatLng> _gridCentres(LatLngBounds bbox, double resolutionNm) {
  final rows = (bbox.heightNm / resolutionNm).ceil().clamp(1, 200);
  final cols = (bbox.widthNm / resolutionNm).ceil().clamp(1, 200);
  final latStep = (bbox.northeast.latitude - bbox.southwest.latitude) / rows;
  final lonStep = (bbox.northeast.longitude - bbox.southwest.longitude) / cols;
  final centres = <LatLng>[];
  for (var i = 0; i < rows; i++) {
    for (var j = 0; j < cols; j++) {
      centres.add(
        LatLng(
          latitude: bbox.southwest.latitude + (i + 0.5) * latStep,
          longitude: bbox.southwest.longitude + (j + 0.5) * lonStep,
        ),
      );
    }
  }
  return centres;
}

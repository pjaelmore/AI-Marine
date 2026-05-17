import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:maplibre_gl/maplibre_gl.dart' show LatLng;

import '../../core/types/score_result.dart';
import '../design/colors.dart';
import 'marine_chart_view.dart';

/// One palette stop in the heatmap: scores in `[minScore, maxScore)`
/// render in `color` at `opacity`. Stops are checked in order and the
/// first match wins; scores below the first stop's `minScore` produce
/// no cell (transparent), matching TDD §10.2.2 — cells under 4.0 are
/// not drawn so the chart isn't dominated by "cold" amber where
/// fishing is genuinely poor.
class HeatmapPaletteStop {
  const HeatmapPaletteStop({
    required this.minScore,
    required this.maxScore,
    required this.color,
    required this.opacity,
  });

  final double minScore;
  final double maxScore;
  final Color color;
  final double opacity;
}

/// Three-stop heatmap palette focused on "actually good" spots —
/// olive transition at the 7.0 inflection, teal-mid for solid 7.5–9.0
/// fishing, deep teal for peak 9.0+. Scores under 7.0 render no cell
/// so the chart isn't drowned in tepid amber where fishing is just
/// "fine." TDD §10.2.2's amber bands are intentionally omitted — the
/// heatmap surfaces *recommendations*, not "here's everywhere I
/// scored you something."
const heatmapPalette = <HeatmapPaletteStop>[
  HeatmapPaletteStop(
    minScore: 7.0,
    maxScore: 7.5,
    color: Color(0xFF7B8A4F), // olive transition
    opacity: 0.35,
  ),
  HeatmapPaletteStop(
    minScore: 7.5,
    maxScore: 9.0,
    color: MarineColors.actionTeal,
    opacity: 0.45,
  ),
  HeatmapPaletteStop(
    minScore: 9.0,
    maxScore: 10.001, // inclusive of a perfect 10
    color: MarineColors.actionTeal,
    opacity: 0.65,
  ),
];

/// Resolves the palette stop for a given score, or null when the
/// score is below the first stop's floor (don't draw a cell).
HeatmapPaletteStop? paletteFor(double score) {
  for (final stop in heatmapPalette) {
    if (score >= stop.minScore && score < stop.maxScore) return stop;
  }
  return null;
}

/// Converts a [ScoreResult] grid (one row per cell centre, output of
/// [scoreGridProvider]) plus the resolution that produced it into a
/// list of [HeatmapCellSpec] ready for [MarineChartView]. Cells with
/// no palette match (score < 4.0) are dropped so the chart isn't
/// drowned in low-confidence amber.
///
/// Cell side in degrees is derived from `resolutionNm`. Latitude
/// extent is constant (1° ≈ 60 nm); longitude extent shrinks with
/// cos(latitude) so cells stay roughly square in nautical miles at
/// the centre latitude.
List<HeatmapCellSpec> buildHeatmapCells(
  List<ScoreResult> grid,
  double resolutionNm,
) {
  if (grid.isEmpty) return const [];
  // Use the first cell's latitude for the cosine factor — over a
  // typical viewport the latitude swing is < 1° so a single factor
  // is fine.
  final centerLat = grid.first.location.latitude;
  final dLat = resolutionNm / 120.0;
  final cosLat = math.cos(centerLat * math.pi / 180).abs();
  final dLon = resolutionNm / (120.0 * math.max(cosLat, 0.01));
  final out = <HeatmapCellSpec>[];
  for (final score in grid) {
    final stop = paletteFor(score.finalScore);
    if (stop == null) continue;
    out.add(
      HeatmapCellSpec(
        center: LatLng(score.location.latitude, score.location.longitude),
        halfSideDegLat: dLat,
        halfSideDegLon: dLon,
        fillColorHex: _hex(stop.color),
        fillOpacity: stop.opacity,
      ),
    );
  }
  return out;
}

/// Converts a [Color] to the `#RRGGBB` string maplibre's fill APIs
/// expect.
String _hex(Color c) {
  final r = c.red.toRadixString(16).padLeft(2, '0');
  final g = c.green.toRadixString(16).padLeft(2, '0');
  final b = c.blue.toRadixString(16).padLeft(2, '0');
  return '#$r$g$b';
}

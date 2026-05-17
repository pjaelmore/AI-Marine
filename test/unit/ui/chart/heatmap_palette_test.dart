import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/ui/chart/heatmap_palette.dart';
import 'package:flutter_test/flutter_test.dart';

ScoreResult _score(double finalScore, {double lat = 28.4, double lon = -80.4}) {
  return ScoreResult(
    speciesId: 'common-snook',
    location: LatLng(latitude: lat, longitude: lon),
    time: DateTime.utc(2026, 5, 10, 12),
    finalScore: finalScore,
    confidence: 0.85,
    reasoning: const ReasoningBreakdown(
      baseProbability: 0.95,
      gates: [],
      modifiers: [],
      contributors: [],
      rawScoreBeforeContributors: 0,
      additiveTotal: 0,
      finalScore: 0,
      migrationSummary: '',
      suggestedApproach: '',
    ),
  );
}

void main() {
  group('paletteFor', () {
    test('scores under 7.0 produce no palette stop (cell is dropped)', () {
      // Amber bands are intentionally omitted — heatmap surfaces
      // recommendations, not "everywhere I scored something."
      expect(paletteFor(0), isNull);
      expect(paletteFor(4.0), isNull);
      expect(paletteFor(6.99), isNull);
    });

    test('olive transition band covers [7.0, 7.5)', () {
      expect(paletteFor(7.0)?.opacity, 0.35);
      expect(paletteFor(7.49)?.opacity, 0.35);
    });

    test('green-mid band covers [7.5, 9.0)', () {
      expect(paletteFor(7.5)?.opacity, 0.45);
      expect(paletteFor(8.99)?.opacity, 0.45);
    });

    test('green-high band covers [9.0, 10.0] inclusive of 10', () {
      expect(paletteFor(9.0)?.opacity, 0.65);
      expect(paletteFor(10.0)?.opacity, 0.65);
    });
  });

  group('buildHeatmapCells', () {
    test('empty grid produces empty cell list', () {
      expect(buildHeatmapCells(const [], 5.0), isEmpty);
    });

    test('drops cells under the 7.0 floor', () {
      final cells = buildHeatmapCells(
        [_score(3.5), _score(6.9), _score(7.0), _score(8.5)],
        5.0,
      );
      // Only 7.0 and 8.5 survive.
      expect(cells, hasLength(2));
    });

    test('half-side latitude is resolutionNm / 120 (1° ≈ 60 nm)', () {
      final cells = buildHeatmapCells([_score(8.0)], 6.0);
      // 6 nm half-side = 0.05° latitude
      expect(cells.single.halfSideDegLat, closeTo(0.05, 1e-9));
    });

    test('half-side longitude scales by cos(centre lat) at FL', () {
      // At 28.4°N, cos(28.4°) ≈ 0.880. 6 nm halfside lon ≈ 0.05 / 0.880 ≈ 0.0568.
      final cells = buildHeatmapCells([_score(8.0, lat: 28.4)], 6.0);
      expect(cells.single.halfSideDegLon, closeTo(0.0568, 1e-3));
    });

    test('renders the cell centre at the score result location', () {
      final cells = buildHeatmapCells(
        [_score(8.0, lat: 28.4, lon: -80.4)],
        5.0,
      );
      expect(cells.single.center.latitude, 28.4);
      expect(cells.single.center.longitude, -80.4);
    });

    test('maps green score to MarineColors.actionTeal', () {
      final green = buildHeatmapCells([_score(8.0)], 5.0).single;
      // MarineColors.actionTeal = #0F6E56
      expect(green.fillColorHex.toUpperCase(), '#0F6E56');
    });

    test('maps borderline 7.0 score to the olive transition colour', () {
      final olive = buildHeatmapCells([_score(7.0)], 5.0).single;
      expect(olive.fillColorHex.toUpperCase(), '#7B8A4F');
    });
  });
}

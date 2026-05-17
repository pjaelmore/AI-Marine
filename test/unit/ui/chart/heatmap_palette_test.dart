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
    test('scores under 4.0 produce no palette stop (cell is dropped)', () {
      expect(paletteFor(0), isNull);
      expect(paletteFor(3.99), isNull);
    });

    test('amber-low band covers [4.0, 5.5)', () {
      expect(paletteFor(4.0)?.opacity, 0.20);
      expect(paletteFor(5.49)?.opacity, 0.20);
    });

    test('amber-mid band covers [5.5, 7.0)', () {
      expect(paletteFor(5.5)?.opacity, 0.35);
      expect(paletteFor(6.99)?.opacity, 0.35);
    });

    test('olive transition band covers [7.0, 7.5)', () {
      final stop = paletteFor(7.0);
      expect(stop, isNotNull);
      expect(stop!.opacity, 0.30);
      expect(stop.maxScore, 7.5);
    });

    test('green-mid band covers [7.5, 9.0)', () {
      expect(paletteFor(7.5)?.opacity, 0.35);
      expect(paletteFor(8.99)?.opacity, 0.35);
    });

    test('green-high band covers [9.0, 10.0] inclusive of 10', () {
      expect(paletteFor(9.0)?.opacity, 0.45);
      expect(paletteFor(10.0)?.opacity, 0.45);
    });
  });

  group('buildHeatmapCells', () {
    test('empty grid produces empty cell list', () {
      expect(buildHeatmapCells(const [], 5.0), isEmpty);
    });

    test('drops cells whose score falls below the palette floor', () {
      final cells = buildHeatmapCells(
        [_score(3.5), _score(5.0), _score(2.0)],
        5.0,
      );
      // Only the 5.0 cell survives.
      expect(cells, hasLength(1));
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

    test('maps amber and green scores to the documented hex colours', () {
      final amber = buildHeatmapCells([_score(5.0)], 5.0).single;
      final green = buildHeatmapCells([_score(8.0)], 5.0).single;
      // MarineColors.warnAmber = #E89F3C
      expect(amber.fillColorHex.toUpperCase(), '#E89F3C');
      // MarineColors.actionTeal = #0F6E56
      expect(green.fillColorHex.toUpperCase(), '#0F6E56');
    });
  });
}

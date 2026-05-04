import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/services/calculator/migration_gate.dart';
import 'package:flutter_test/flutter_test.dart';

/// 1° box around Boston Harbor (42–43°N, -71 to -70°W).
GeoPolygon _bostonBox() => const GeoPolygon(
      rings: [
        [
          LatLng(latitude: 42, longitude: -71),
          LatLng(latitude: 43, longitude: -71),
          LatLng(latitude: 43, longitude: -70),
          LatLng(latitude: 42, longitude: -70),
          LatLng(latitude: 42, longitude: -71),
        ],
      ],
    );

/// Smaller box covering just the harbor mouth.
GeoPolygon _harborMouthBox() => const GeoPolygon(
      rings: [
        [
          LatLng(latitude: 42.3, longitude: -70.7),
          LatLng(latitude: 42.4, longitude: -70.7),
          LatLng(latitude: 42.4, longitude: -70.5),
          LatLng(latitude: 42.3, longitude: -70.5),
          LatLng(latitude: 42.3, longitude: -70.7),
        ],
      ],
    );

const _bostonHarbor = LatLng(latitude: 42.36, longitude: -70.55);
const _greenland = LatLng(latitude: 64.0, longitude: -50.0);

/// 52-element weekly curve where [presentWeeks] (1-indexed) carry [value]
/// and every other week is 0.
List<double> _weeks({required Set<int> presentWeeks, double value = 1.0}) {
  return List<double>.generate(
    52,
    (i) => presentWeeks.contains(i + 1) ? value : 0.0,
  );
}

void main() {
  group('evaluateMigrationGate — spatial range', () {
    test('fails when location is outside the spatial range', () {
      final model = MigrationModel(spatialRange: _bostonBox());
      final r = evaluateMigrationGate(
        migration: model,
        location: _greenland,
        time: DateTime.utc(2026, 5, 22),
      );
      expect(r.passed, isFalse);
      expect(r.failureReason, contains('outside'));
    });

    test('passes when inside spatial range and no regional curves are loaded',
        () {
      final model = MigrationModel(spatialRange: _bostonBox());
      final r = evaluateMigrationGate(
        migration: model,
        location: _bostonHarbor,
        time: DateTime.utc(2026, 5, 22),
      );
      expect(r.passed, isTrue);
      expect(r.failureReason, isNull);
    });
  });

  group('evaluateMigrationGate — regional curve presence', () {
    test('passes when a covering curve has non-zero presence this week', () {
      // May 22, 2026 → week 21. Set week 21 active.
      final model = MigrationModel(
        spatialRange: _bostonBox(),
        regionalCurves: [
          RegionalPresenceCurve(
            regionId: 'boston_harbor',
            regionPolygon: _harborMouthBox(),
            weeklyValues: _weeks(presentWeeks: {21}),
          ),
        ],
      );
      final r = evaluateMigrationGate(
        migration: model,
        location: _bostonHarbor,
        time: DateTime.utc(2026, 5, 22),
      );
      expect(r.passed, isTrue);
    });

    test('fails when the only covering curve reports zero presence', () {
      // Curve is loaded but week 21 is zero (only weeks 1-10 active).
      final model = MigrationModel(
        spatialRange: _bostonBox(),
        regionalCurves: [
          RegionalPresenceCurve(
            regionId: 'boston_harbor',
            regionPolygon: _harborMouthBox(),
            weeklyValues: _weeks(presentWeeks: {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}),
          ),
        ],
      );
      final r = evaluateMigrationGate(
        migration: model,
        location: _bostonHarbor,
        time: DateTime.utc(2026, 5, 22),
      );
      expect(r.passed, isFalse);
      expect(
        r.failureReason,
        contains('boston_harbor'),
        reason: 'failure reason should name the failing region',
      );
    });

    test(
      'passes when the location is in spatial range but no curve covers it',
      () {
        // Curve is loaded but its polygon doesn't include _bostonHarbor.
        const farEastBox = GeoPolygon(
          rings: [
            [
              LatLng(latitude: 42.7, longitude: -70.2),
              LatLng(latitude: 42.8, longitude: -70.2),
              LatLng(latitude: 42.8, longitude: -70.1),
              LatLng(latitude: 42.7, longitude: -70.1),
              LatLng(latitude: 42.7, longitude: -70.2),
            ],
          ],
        );
        final model = MigrationModel(
          spatialRange: _bostonBox(),
          regionalCurves: [
            RegionalPresenceCurve(
              regionId: 'far_east',
              regionPolygon: farEastBox,
              weeklyValues: _weeks(presentWeeks: const <int>{}),
            ),
          ],
        );
        final r = evaluateMigrationGate(
          migration: model,
          location: _bostonHarbor,
          time: DateTime.utc(2026, 5, 22),
        );
        expect(
          r.passed,
          isTrue,
          reason: 'data gap on this point != absence',
        );
      },
    );
  });

  group('evaluateMigrationGate — overlapping curves', () {
    test(
      'max-of-many: an overlapping high-presence curve carries the gate '
      'even when a coarser curve is zero',
      () {
        final model = MigrationModel(
          spatialRange: _bostonBox(),
          regionalCurves: [
            // Coarse regional curve, zero this week.
            RegionalPresenceCurve(
              regionId: 'gulf_of_maine_coarse',
              regionPolygon: _bostonBox(),
              weeklyValues: _weeks(presentWeeks: const <int>{}),
            ),
            // Fine-grained harbor-mouth curve, active this week.
            RegionalPresenceCurve(
              regionId: 'boston_harbor_fine',
              regionPolygon: _harborMouthBox(),
              weeklyValues: _weeks(presentWeeks: {21}),
            ),
          ],
        );
        final r = evaluateMigrationGate(
          migration: model,
          location: _bostonHarbor,
          time: DateTime.utc(2026, 5, 22),
        );
        expect(r.passed, isTrue);
      },
    );

    test('all overlapping curves zero → gate fails', () {
      final model = MigrationModel(
        spatialRange: _bostonBox(),
        regionalCurves: [
          RegionalPresenceCurve(
            regionId: 'gulf_of_maine',
            regionPolygon: _bostonBox(),
            weeklyValues: _weeks(presentWeeks: const <int>{}),
          ),
          RegionalPresenceCurve(
            regionId: 'boston_harbor',
            regionPolygon: _harborMouthBox(),
            weeklyValues: _weeks(presentWeeks: const <int>{}),
          ),
        ],
      );
      final r = evaluateMigrationGate(
        migration: model,
        location: _bostonHarbor,
        time: DateTime.utc(2026, 5, 22),
      );
      expect(r.passed, isFalse);
    });
  });
}

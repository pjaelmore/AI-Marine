import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/services/calculator/migration_base_probability.dart';
import 'package:flutter_test/flutter_test.dart';

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
const _greenland = LatLng(latitude: 64, longitude: -50);

List<double> _weeks({required Map<int, double> values}) =>
    List<double>.generate(52, (i) => values[i + 1] ?? 0.0);

void main() {
  group('calculateMigrationBaseProbability', () {
    test('returns 0 when the location is outside the spatial range', () {
      final model = MigrationModel(spatialRange: _bostonBox());
      expect(
        calculateMigrationBaseProbability(
          migration: model,
          location: _greenland,
          time: DateTime.utc(2026, 5, 22),
        ),
        0,
      );
    });

    test(
      'returns the documented 0.5 default when no regional curve covers',
      () {
        // No regional curves at all — location is inside spatial range.
        final model = MigrationModel(spatialRange: _bostonBox());
        expect(
          calculateMigrationBaseProbability(
            migration: model,
            location: _bostonHarbor,
            time: DateTime.utc(2026, 5, 22),
          ),
          0.5,
        );
      },
    );

    test(
      'returns the covering curve\'s presence at the right week-of-year',
      () {
        // May 22, 2026 → week 21. Set week 21 to 0.7.
        final model = MigrationModel(
          spatialRange: _bostonBox(),
          regionalCurves: [
            RegionalPresenceCurve(
              regionId: 'boston_harbor',
              regionPolygon: _harborMouthBox(),
              weeklyValues: _weeks(values: {21: 0.7}),
            ),
          ],
        );
        expect(
          calculateMigrationBaseProbability(
            migration: model,
            location: _bostonHarbor,
            time: DateTime.utc(2026, 5, 22),
          ),
          0.7,
        );
      },
    );

    test(
      'returns 0 when the only covering curve is zero this week '
      '(consistent with gate fail)',
      () {
        final model = MigrationModel(
          spatialRange: _bostonBox(),
          regionalCurves: [
            RegionalPresenceCurve(
              regionId: 'boston_harbor',
              regionPolygon: _harborMouthBox(),
              weeklyValues: _weeks(values: const {}),
            ),
          ],
        );
        expect(
          calculateMigrationBaseProbability(
            migration: model,
            location: _bostonHarbor,
            time: DateTime.utc(2026, 5, 22),
          ),
          0,
        );
      },
    );

    test(
      'overlapping curves: returns the max presence across them',
      () {
        // Coarse curve says 0.2; fine curve says 0.9. Caller should
        // get 0.9 — same max-of-many policy as the gate.
        final model = MigrationModel(
          spatialRange: _bostonBox(),
          regionalCurves: [
            RegionalPresenceCurve(
              regionId: 'gulf_of_maine',
              regionPolygon: _bostonBox(),
              weeklyValues: _weeks(values: {21: 0.2}),
            ),
            RegionalPresenceCurve(
              regionId: 'boston_harbor',
              regionPolygon: _harborMouthBox(),
              weeklyValues: _weeks(values: {21: 0.9}),
            ),
          ],
        );
        expect(
          calculateMigrationBaseProbability(
            migration: model,
            location: _bostonHarbor,
            time: DateTime.utc(2026, 5, 22),
          ),
          0.9,
        );
      },
    );

    test(
      'uses the data-gap default when curves exist but none cover the point',
      () {
        // Curve loaded but its polygon doesn't include the location.
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
              weeklyValues: _weeks(values: {21: 0.9}),
            ),
          ],
        );
        expect(
          calculateMigrationBaseProbability(
            migration: model,
            location: _bostonHarbor,
            time: DateTime.utc(2026, 5, 22),
          ),
          0.5,
          reason: 'no covering curve → data-gap default, not zero',
        );
      },
    );
  });
}

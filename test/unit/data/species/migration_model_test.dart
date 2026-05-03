import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:flutter_test/flutter_test.dart';

const _massBay = GeoPolygon(
  rings: [
    [
      LatLng(latitude: 42.0, longitude: -71.0),
      LatLng(latitude: 42.0, longitude: -70.0),
      LatLng(latitude: 43.0, longitude: -70.0),
      LatLng(latitude: 43.0, longitude: -71.0),
    ],
  ],
);

void main() {
  group('Population JSON round-trip', () {
    test('preserves all fields', () {
      const original = Population(
        id: 'chesapeake',
        displayName: 'Chesapeake migrants',
        description: 'Spring run from the Chesapeake stocks.',
        regionIds: ['ma_state_waters', 'ri_state_waters'],
      );
      expect(Population.fromJson(original.toJson()), original);
    });
  });

  group('RegionalPresenceCurve.presenceAt', () {
    final weeklyValues = List<double>.generate(52, (i) => i / 51);
    final curve = RegionalPresenceCurve(
      regionId: 'mass_bay',
      regionPolygon: _massBay,
      weeklyValues: weeklyValues,
    );

    test('returns the week-of-year slot', () {
      // Day 8 (January 8) is in week 2 -> weeklyValues[1] = 1/51.
      expect(
        curve.presenceAt(DateTime(2026, 1, 8)),
        closeTo(1 / 51, 1e-9),
      );
    });

    test('returns 0 for an empty curve', () {
      const empty = RegionalPresenceCurve(
        regionId: 'empty',
        regionPolygon: _massBay,
        weeklyValues: [],
      );
      expect(empty.presenceAt(DateTime(2026, 5, 22)), 0.0);
    });

    test('clamps gracefully if week beyond array length', () {
      // weeklyValues length 10, week 30 -> clamps to last index.
      final shortCurve = RegionalPresenceCurve(
        regionId: 'short',
        regionPolygon: _massBay,
        weeklyValues: List<double>.filled(10, 0.5),
      );
      expect(shortCurve.presenceAt(DateTime(2026, 7, 1)), 0.5);
    });

    test('JSON round-trip preserves rings and weekly values', () {
      final restored = RegionalPresenceCurve.fromJson(curve.toJson());
      expect(restored, curve);
    });
  });

  group('MigrationCorridor JSON round-trip', () {
    test('preserves path coordinates and active weeks', () {
      const original = MigrationCorridor(
        id: 'chesapeake_to_cape_cod',
        path: [
          LatLng(latitude: 37.0, longitude: -76.0),
          LatLng(latitude: 41.5, longitude: -70.5),
        ],
        widthNm: 25.0,
        activeWeekStart: 16,
        activeWeekEnd: 22,
      );
      expect(MigrationCorridor.fromJson(original.toJson()), original);
    });
  });

  group('TriggerRule JSON round-trip', () {
    test('preserves open-shape parameters map', () {
      const original = TriggerRule(
        id: 'sst_anomaly_north_atl',
        kind: TriggerKind.sstAnomalyShift,
        parameters: {
          'thresholdDegF': 2.0,
          'shiftDays': 5,
          'enabled': true,
        },
      );
      expect(TriggerRule.fromJson(original.toJson()), original);
    });

    test('parameters defaults to empty map', () {
      const rule = TriggerRule(id: 'r1', kind: TriggerKind.custom);
      expect(rule.parameters, isEmpty);
      expect(TriggerRule.fromJson(rule.toJson()), rule);
    });
  });

  group('MigrationModel JSON round-trip', () {
    test('preserves spatial range and all child collections', () {
      final model = MigrationModel(
        spatialRange: _massBay,
        populations: const [
          Population(
            id: 'chesapeake',
            displayName: 'Chesapeake',
            description: '',
          ),
        ],
        regionalCurves: [
          RegionalPresenceCurve(
            regionId: 'mass_bay',
            regionPolygon: _massBay,
            weeklyValues: List<double>.filled(52, 0.5),
          ),
        ],
        corridors: const [
          MigrationCorridor(
            id: 'c1',
            path: [LatLng(latitude: 37.0, longitude: -76.0)],
            widthNm: 25.0,
            activeWeekStart: 16,
            activeWeekEnd: 22,
          ),
        ],
        triggers: const [
          TriggerRule(id: 't1', kind: TriggerKind.photoperiodThreshold),
        ],
      );
      final restored = MigrationModel.fromJson(model.toJson());
      expect(restored, model);
    });

    test('default child collections are empty', () {
      const model = MigrationModel(spatialRange: _massBay);
      expect(model.populations, isEmpty);
      expect(model.regionalCurves, isEmpty);
      expect(model.corridors, isEmpty);
      expect(model.triggers, isEmpty);
    });
  });
}

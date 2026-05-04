import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/services/calculator/modifiers/water_temp_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

/// Striped-bass-flavored ranges for tests. Tolerated 50–75°F, optimal
/// 60–68°F. Exact values are illustrative; calibration tuples in a
/// later slice will pin real species data.
const _optimal = TemperatureRange(minF: 60, maxF: 68, idealF: 64);
const _tolerated = TemperatureRange(minF: 50, maxF: 75, idealF: 64);

void main() {
  group('evaluateWaterTempModifier — value envelope', () {
    test('returns ModifierApplication with name and rangeMin/rangeMax', () {
      final r = evaluateWaterTempModifier(
        waterTempF: 64,
        optimalTemp: _optimal,
        toleratedTemp: _tolerated,
      );
      expect(r.name, 'water_temperature');
      expect(r.rangeMin, 0);
      expect(r.rangeMax, 2);
      expect(r.description, contains('64.0°F'));
      expect(r.description, contains('60–68°F'));
    });
  });

  group('evaluateWaterTempModifier — plateau (inside optimal)', () {
    test('water temp at the lower optimal edge gives max multiplier (2.0)', () {
      expect(
        evaluateWaterTempModifier(
          waterTempF: 60,
          optimalTemp: _optimal,
          toleratedTemp: _tolerated,
        ).value,
        2.0,
      );
    });

    test('water temp at the upper optimal edge gives max multiplier (2.0)', () {
      expect(
        evaluateWaterTempModifier(
          waterTempF: 68,
          optimalTemp: _optimal,
          toleratedTemp: _tolerated,
        ).value,
        2.0,
      );
    });

    test('water temp at idealF gives max multiplier (2.0)', () {
      expect(
        evaluateWaterTempModifier(
          waterTempF: 64,
          optimalTemp: _optimal,
          toleratedTemp: _tolerated,
        ).value,
        2.0,
      );
    });
  });

  group('evaluateWaterTempModifier — outside tolerated', () {
    test('water temp at toleratedTemp.minF returns 0 (range bound exclusive)',
        () {
      expect(
        evaluateWaterTempModifier(
          waterTempF: 50,
          optimalTemp: _optimal,
          toleratedTemp: _tolerated,
        ).value,
        0,
      );
    });

    test('water temp well above tolerated max returns 0', () {
      expect(
        evaluateWaterTempModifier(
          waterTempF: 90,
          optimalTemp: _optimal,
          toleratedTemp: _tolerated,
        ).value,
        0,
      );
    });

    test('water temp well below tolerated min returns 0', () {
      expect(
        evaluateWaterTempModifier(
          waterTempF: 30,
          optimalTemp: _optimal,
          toleratedTemp: _tolerated,
        ).value,
        0,
      );
    });
  });

  group('evaluateWaterTempModifier — linear ramps', () {
    test(
      'rising-edge midpoint (55°F) reads neutral multiplier 1.0',
      () {
        // Tolerated.minF = 50, optimal.minF = 60 → midpoint = 55,
        // preference = 0.5, multiplier = 2 × 0.5 = 1.0.
        expect(
          evaluateWaterTempModifier(
            waterTempF: 55,
            optimalTemp: _optimal,
            toleratedTemp: _tolerated,
          ).value,
          closeTo(1.0, 1e-9),
        );
      },
    );

    test(
      'falling-edge midpoint (71.5°F) reads neutral multiplier 1.0',
      () {
        // Optimal.maxF = 68, tolerated.maxF = 75 → midpoint = 71.5,
        // preference = 0.5, multiplier = 1.0.
        expect(
          evaluateWaterTempModifier(
            waterTempF: 71.5,
            optimalTemp: _optimal,
            toleratedTemp: _tolerated,
          ).value,
          closeTo(1.0, 1e-9),
        );
      },
    );

    test(
      'rising edge: monotone increase from tolerated.min toward optimal.min',
      () {
        double m(double tF) => evaluateWaterTempModifier(
              waterTempF: tF,
              optimalTemp: _optimal,
              toleratedTemp: _tolerated,
            ).value;
        expect(m(52) < m(54), isTrue);
        expect(m(54) < m(56), isTrue);
        expect(m(56) < m(58), isTrue);
      },
    );
  });
}

import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/services/calculator/modifiers/wind_speed_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

ModifierApplication _eval(double kt) => evaluateWindSpeedModifier(
      wind: WindVector(speedKnots: kt, directionDegrees: 0),
    );

void main() {
  group('evaluateWindSpeedModifier — envelope', () {
    test('returns ModifierApplication with name and rangeMin/rangeMax', () {
      final r = _eval(10);
      expect(r.name, 'wind_speed');
      expect(r.rangeMin, 0);
      expect(r.rangeMax, 2);
      expect(r.description, contains('10.0 kt'));
    });
  });

  group('evaluateWindSpeedModifier — comfort plateau', () {
    test('dead calm (0 kt) reads max multiplier 2.0', () {
      // Boundary-edge case the inline math fixes vs the trapezoid
      // helper's range-bound exclusivity.
      expect(_eval(0).value, 2.0);
    });

    test('mid-plateau speeds (1 / 7 / 15 kt) all read max multiplier 2.0', () {
      expect(_eval(1).value, 2.0);
      expect(_eval(7).value, 2.0);
      expect(_eval(15).value, 2.0);
    });
  });

  group('evaluateWindSpeedModifier — linear falloff', () {
    test('22.5 kt (midpoint of 15→30 falloff) reads neutral multiplier 1.0',
        () {
      expect(_eval(22.5).value, closeTo(1.0, 1e-9));
    });

    test(
      'falloff is monotone decreasing across 15..30',
      () {
        expect(_eval(16).value > _eval(20).value, isTrue);
        expect(_eval(20).value > _eval(25).value, isTrue);
        expect(_eval(25).value > _eval(29).value, isTrue);
      },
    );
  });

  group('evaluateWindSpeedModifier — small-craft advisory', () {
    test('exactly 30 kt reads 0 (boundary inclusive on the kill side)', () {
      expect(_eval(30).value, 0);
    });

    test('40 kt and 60 kt both read 0', () {
      expect(_eval(40).value, 0);
      expect(_eval(60).value, 0);
    });
  });
}

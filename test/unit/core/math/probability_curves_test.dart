import 'package:ai_marine_engine/core/math/probability_curves.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('trapezoidAt — endpoints and plateau', () {
    test('returns 0 at and outside the range bounds', () {
      double f(double v) => trapezoidAt(
            value: v,
            rangeMin: 50,
            idealLow: 60,
            idealHigh: 70,
            rangeMax: 80,
          );
      expect(f(50), 0);
      expect(f(80), 0);
      expect(f(30), 0);
      expect(f(100), 0);
    });

    test('returns 1 across the ideal plateau (inclusive on both ends)', () {
      double f(double v) => trapezoidAt(
            value: v,
            rangeMin: 50,
            idealLow: 60,
            idealHigh: 70,
            rangeMax: 80,
          );
      expect(f(60), 1);
      expect(f(65), 1);
      expect(f(70), 1);
    });
  });

  group('trapezoidAt — linear ramps', () {
    test('rising-edge midpoint reads 0.5', () {
      // rangeMin=50, idealLow=60. Midpoint = 55.
      expect(
        trapezoidAt(
          value: 55,
          rangeMin: 50,
          idealLow: 60,
          idealHigh: 70,
          rangeMax: 80,
        ),
        closeTo(0.5, 1e-9),
      );
    });

    test('falling-edge midpoint reads 0.5', () {
      // idealHigh=70, rangeMax=80. Midpoint = 75.
      expect(
        trapezoidAt(
          value: 75,
          rangeMin: 50,
          idealLow: 60,
          idealHigh: 70,
          rangeMax: 80,
        ),
        closeTo(0.5, 1e-9),
      );
    });

    test('rising edge is strictly increasing across its span', () {
      double f(double v) => trapezoidAt(
            value: v,
            rangeMin: 50,
            idealLow: 60,
            idealHigh: 70,
            rangeMax: 80,
          );
      expect(f(52) < f(54), isTrue);
      expect(f(54) < f(56), isTrue);
      expect(f(56) < f(58), isTrue);
    });
  });

  group('trapezoidAt — degenerate shapes', () {
    test('triangle: idealLow == idealHigh peaks at the single ideal', () {
      // 50..65..65..80 — pure triangle.
      double f(double v) => trapezoidAt(
            value: v,
            rangeMin: 50,
            idealLow: 65,
            idealHigh: 65,
            rangeMax: 80,
          );
      expect(f(65), 1);
      expect(f(57.5), closeTo(0.5, 1e-9)); // halfway up the rise
      expect(f(72.5), closeTo(0.5, 1e-9)); // halfway down the fall
    });

    test('half-triangle: ideal sits on rangeMin (no rising edge)', () {
      // 50..50..70..80 — value below 50 still 0; from 50 onward, full plateau
      // through 70, then linear fall to 0 at 80.
      double f(double v) => trapezoidAt(
            value: v,
            rangeMin: 50,
            idealLow: 50,
            idealHigh: 70,
            rangeMax: 80,
          );
      expect(f(40), 0);
      expect(
        f(50),
        0,
        reason: 'value == rangeMin returns 0 (range bound is exclusive)',
      );
      expect(f(60), 1);
      expect(f(70), 1);
      expect(f(75), closeTo(0.5, 1e-9));
    });

    test('half-triangle: ideal sits on rangeMax (no falling edge)', () {
      double f(double v) => trapezoidAt(
            value: v,
            rangeMin: 50,
            idealLow: 60,
            idealHigh: 80,
            rangeMax: 80,
          );
      expect(f(55), closeTo(0.5, 1e-9));
      expect(f(70), 1);
      expect(
        f(80),
        0,
        reason: 'value == rangeMax returns 0 (range bound is exclusive)',
      );
    });
  });

  group('triangleAt convenience', () {
    test('matches trapezoidAt with idealLow == idealHigh', () {
      double a(double v) =>
          triangleAt(value: v, rangeMin: 50, ideal: 65, rangeMax: 80);
      double b(double v) => trapezoidAt(
            value: v,
            rangeMin: 50,
            idealLow: 65,
            idealHigh: 65,
            rangeMax: 80,
          );
      for (final v in const [55.0, 60.0, 65.0, 70.0, 75.0]) {
        expect(a(v), b(v));
      }
    });
  });
}

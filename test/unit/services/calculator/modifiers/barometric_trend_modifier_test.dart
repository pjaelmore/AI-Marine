import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/services/calculator/modifiers/barometric_trend_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

/// Snook-flavored sensitivity for tests. Snook fire on falling pressure
/// (front incoming), tolerate post-front clearing weakly, neutral on
/// stable. frontalPassageFactor and cloudCoverPreference unused here.
const _snookSensitivity = WeatherSensitivity(
  risingPressureFactor: 1.1,
  fallingPressureFactor: 1.6,
  frontalPassageFactor: 1.4,
  cloudCoverPreference: 0.6,
);

ModifierApplication _eval(BarometricTrend trend, {double pressure = 1015}) =>
    evaluateBarometricTrendModifier(
      barometric: BarometricState(
        pressureMillibars: pressure,
        trend: trend,
        rateOfChangeMillibarsPerHour: 0,
      ),
      sensitivity: _snookSensitivity,
    );

void main() {
  group('evaluateBarometricTrendModifier — envelope', () {
    test('returns ModifierApplication with name and rangeMin/rangeMax', () {
      final r = _eval(BarometricTrend.stable, pressure: 1015.4);
      expect(r.name, 'barometric_trend');
      expect(r.rangeMin, 0);
      expect(r.rangeMax, 2);
      expect(r.description, contains('stable'));
      expect(r.description, contains('1015.4 hPa'));
    });
  });

  group('evaluateBarometricTrendModifier — trend dispatch', () {
    test('rising trend uses risingPressureFactor (1.1 for snook)', () {
      expect(_eval(BarometricTrend.rising).value, 1.1);
    });

    test('falling trend uses fallingPressureFactor (1.6 for snook)', () {
      expect(_eval(BarometricTrend.falling).value, 1.6);
    });

    test('stable trend reads neutral 1.0 regardless of species data', () {
      // No stableFactor field on the species type — stable absence-of-
      // change shouldn't help or hurt by itself.
      expect(_eval(BarometricTrend.stable).value, 1.0);
    });
  });

  group('evaluateBarometricTrendModifier — clamping', () {
    test('a 5x boost in species data is clamped to 2.0', () {
      // Defensive: a poorly-tuned species file doesn't get to violate
      // the bar viz envelope.
      const overzealous = WeatherSensitivity(
        risingPressureFactor: 1.0,
        fallingPressureFactor: 5.0,
        frontalPassageFactor: 1.0,
        cloudCoverPreference: 0.5,
      );
      final r = evaluateBarometricTrendModifier(
        barometric: const BarometricState(
          pressureMillibars: 1010,
          trend: BarometricTrend.falling,
          rateOfChangeMillibarsPerHour: 0,
        ),
        sensitivity: overzealous,
      );
      expect(r.value, 2.0);
    });

    test('a negative factor is clamped to 0', () {
      const malformed = WeatherSensitivity(
        risingPressureFactor: -0.5,
        fallingPressureFactor: 1.5,
        frontalPassageFactor: 1.0,
        cloudCoverPreference: 0.5,
      );
      final r = evaluateBarometricTrendModifier(
        barometric: const BarometricState(
          pressureMillibars: 1020,
          trend: BarometricTrend.rising,
          rateOfChangeMillibarsPerHour: 0,
        ),
        sensitivity: malformed,
      );
      expect(r.value, 0);
    });
  });

  group('evaluateBarometricTrendModifier — Phase 3 caveat', () {
    test(
      'with NDBC always reporting stable, the modifier reads neutral '
      'until Phase 4+ derives real trend',
      () {
        // Documents the current behavior: BarometricState.trend is
        // hardcoded to stable in conditions_service_impl.getBarometric
        // (Phase 3 NDBC adapter note). This modifier reads 1.0 today.
        final r = _eval(BarometricTrend.stable);
        expect(r.value, 1.0);
      },
    );
  });
}

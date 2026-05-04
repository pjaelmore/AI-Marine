import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/services/calculator/modifiers/solunar_window_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

final _now = DateTime.utc(2026, 5, 22, 18);

SolunarState _state({
  SolunarWindow? major,
  SolunarWindow? minor,
}) =>
    SolunarState(
      sunAltitudeDegrees: 30,
      sunAzimuthDegrees: 250,
      moonPhase: MoonPhase.waxingGibbous,
      moonIlluminationFraction: 0.7,
      majorWindow: major,
      minorWindow: minor,
    );

SolunarWindow _windowAt(DateTime now, {required SolunarStrength strength}) =>
    SolunarWindow(
      start: now.subtract(const Duration(minutes: 30)),
      end: now.add(const Duration(minutes: 30)),
      strength: strength,
    );

SolunarWindow _windowFar(DateTime now, {required SolunarStrength strength}) =>
    SolunarWindow(
      start: now.add(const Duration(hours: 6)),
      end: now.add(const Duration(hours: 7)),
      strength: strength,
    );

void main() {
  group('evaluateSolunarWindowModifier — envelope', () {
    test('returns ModifierApplication with name and rangeMin/rangeMax', () {
      final r = evaluateSolunarWindowModifier(
        solunar: _state(),
        sensitivity: SolunarSensitivity.high,
        time: _now,
      );
      expect(r.name, 'solunar_window');
      expect(r.rangeMin, 0);
      expect(r.rangeMax, 2);
    });
  });

  group('evaluateSolunarWindowModifier — sensitivity = none', () {
    test('always returns 1.0 regardless of window state', () {
      final r = evaluateSolunarWindowModifier(
        solunar:
            _state(major: _windowAt(_now, strength: SolunarStrength.major)),
        sensitivity: SolunarSensitivity.none,
        time: _now,
      );
      expect(r.value, 1.0);
      expect(r.description, contains('not sensitive'));
    });
  });

  group('evaluateSolunarWindowModifier — sensitivity × strength matrix', () {
    test('high × major → 1.6', () {
      expect(
        evaluateSolunarWindowModifier(
          solunar:
              _state(major: _windowAt(_now, strength: SolunarStrength.major)),
          sensitivity: SolunarSensitivity.high,
          time: _now,
        ).value,
        closeTo(1.6, 1e-9),
      );
    });

    test('high × minor → 1.3', () {
      expect(
        evaluateSolunarWindowModifier(
          solunar:
              _state(minor: _windowAt(_now, strength: SolunarStrength.minor)),
          sensitivity: SolunarSensitivity.high,
          time: _now,
        ).value,
        closeTo(1.3, 1e-9),
      );
    });

    test('medium × major → 1.3', () {
      expect(
        evaluateSolunarWindowModifier(
          solunar:
              _state(major: _windowAt(_now, strength: SolunarStrength.major)),
          sensitivity: SolunarSensitivity.medium,
          time: _now,
        ).value,
        closeTo(1.3, 1e-9),
      );
    });

    test('medium × minor → 1.15', () {
      expect(
        evaluateSolunarWindowModifier(
          solunar:
              _state(minor: _windowAt(_now, strength: SolunarStrength.minor)),
          sensitivity: SolunarSensitivity.medium,
          time: _now,
        ).value,
        closeTo(1.15, 1e-9),
      );
    });

    test('low × major → 1.10', () {
      expect(
        evaluateSolunarWindowModifier(
          solunar:
              _state(major: _windowAt(_now, strength: SolunarStrength.major)),
          sensitivity: SolunarSensitivity.low,
          time: _now,
        ).value,
        closeTo(1.10, 1e-9),
      );
    });

    test('low × minor → 1.05', () {
      expect(
        evaluateSolunarWindowModifier(
          solunar:
              _state(minor: _windowAt(_now, strength: SolunarStrength.minor)),
          sensitivity: SolunarSensitivity.low,
          time: _now,
        ).value,
        closeTo(1.05, 1e-9),
      );
    });
  });

  group('evaluateSolunarWindowModifier — inactive windows', () {
    test('windows present but not active at time → 1.0', () {
      final r = evaluateSolunarWindowModifier(
        solunar: _state(
          major: _windowFar(_now, strength: SolunarStrength.major),
          minor: _windowFar(_now, strength: SolunarStrength.minor),
        ),
        sensitivity: SolunarSensitivity.high,
        time: _now,
      );
      expect(r.value, 1.0);
      expect(r.description, contains('inactive'));
    });

    test('null windows → 1.0', () {
      final r = evaluateSolunarWindowModifier(
        solunar: _state(),
        sensitivity: SolunarSensitivity.high,
        time: _now,
      );
      expect(r.value, 1.0);
    });
  });

  group('evaluateSolunarWindowModifier — major precedence', () {
    test('both windows active → major wins (defensive)', () {
      final r = evaluateSolunarWindowModifier(
        solunar: _state(
          major: _windowAt(_now, strength: SolunarStrength.major),
          minor: _windowAt(_now, strength: SolunarStrength.minor),
        ),
        sensitivity: SolunarSensitivity.high,
        time: _now,
      );
      expect(r.value, closeTo(1.6, 1e-9));
      expect(r.description, contains('major'));
    });
  });
}

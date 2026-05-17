import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/services/calculator/modifiers/time_of_day_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

/// Snook-flavored feeding windows: dawn (5–7 AM) strongly, dusk
/// (19–21) strongly, mid-morning (8–10) weakly. Mid-day and the
/// middle of the night fall outside every window.
const _snookWindows = [
  TimeOfDayPreference(startHour: 5, endHour: 7, weight: 0.9),
  TimeOfDayPreference(startHour: 8, endHour: 10, weight: 0.4),
  TimeOfDayPreference(startHour: 19, endHour: 21, weight: 0.85),
];

/// Mahi-flavored feeding windows: diurnal, no night windows.
const _mahiWindows = [
  TimeOfDayPreference(startHour: 6, endHour: 10, weight: 1.0),
  TimeOfDayPreference(startHour: 10, endHour: 16, weight: 0.8),
  TimeOfDayPreference(startHour: 16, endHour: 19, weight: 0.9),
];

DateTime _at(int hour) => DateTime.utc(2026, 5, 22, hour);

void main() {
  group('evaluateTimeOfDayModifier — envelope', () {
    test('returns a modifier in the [0, 2] envelope with the expected name',
        () {
      final r = evaluateTimeOfDayModifier(
        time: _at(6),
        preferences: _snookWindows,
      )!;
      expect(r.name, 'time_of_day');
      expect(r.rangeMin, 0.0);
      expect(r.rangeMax, 2.0);
    });

    test('empty preferences list returns null — caller omits the modifier', () {
      for (final h in [0, 6, 12, 18, 23]) {
        expect(
          evaluateTimeOfDayModifier(time: _at(h), preferences: const []),
          isNull,
          reason: 'hour $h with no preferences should yield null',
        );
      }
    });
  });

  group('evaluateTimeOfDayModifier — inside-window values', () {
    test('weight 1.0 boosts to 1.5 (top of inside-window range)', () {
      final r = evaluateTimeOfDayModifier(
        time: _at(8), // inside mahi 6–10 weight 1.0
        preferences: _mahiWindows,
      )!;
      expect(r.value, closeTo(1.5, 1e-9));
    });

    test('weight 0.4 yields a mild penalty (~1.02) but still above floor', () {
      final r = evaluateTimeOfDayModifier(
        time: _at(9), // inside snook mid-morning weight 0.4
        preferences: _snookWindows,
      )!;
      // value = 0.7 + 0.4 * 0.8 = 1.02
      expect(r.value, closeTo(1.02, 1e-9));
    });

    test('inside-window floor for weight 0 is 0.7 — still above outside floor',
        () {
      const flat = [
        TimeOfDayPreference(startHour: 6, endHour: 7, weight: 0.0),
      ];
      final r = evaluateTimeOfDayModifier(time: _at(6), preferences: flat)!;
      expect(r.value, closeTo(0.7, 1e-9));
    });
  });

  group('evaluateTimeOfDayModifier — outside-window penalty', () {
    test('hour outside every window returns the 0.4 floor', () {
      // 22 falls outside all three mahi windows.
      final r = evaluateTimeOfDayModifier(
        time: _at(22),
        preferences: _mahiWindows,
      )!;
      expect(r.value, closeTo(0.4, 1e-9));
      expect(r.description, contains('Outside feeding windows'));
    });

    test('mahi at 8:39 PM (the bug report) drops below neutral 1.0', () {
      // The user-facing motivation for promoting this from a
      // contributor to a modifier: at hour 20, mahi should not be
      // boosted by feeding-window math. Inside-window boost was the
      // whole problem before.
      final r = evaluateTimeOfDayModifier(
        time: _at(20),
        preferences: _mahiWindows,
      )!;
      expect(r.value, lessThan(1.0));
    });
  });

  group('evaluateTimeOfDayModifier — window bounds and overlap', () {
    test('window bounds are inclusive on both ends', () {
      final atStart = evaluateTimeOfDayModifier(
        time: _at(5),
        preferences: _snookWindows,
      )!;
      final atEnd = evaluateTimeOfDayModifier(
        time: _at(7),
        preferences: _snookWindows,
      )!;
      // weight 0.9 → value 0.7 + 0.9 * 0.8 = 1.42
      expect(atStart.value, closeTo(1.42, 1e-9));
      expect(atEnd.value, closeTo(1.42, 1e-9));
    });

    test('overlapping windows: highest weight wins (max, not sum)', () {
      const overlapping = [
        TimeOfDayPreference(startHour: 6, endHour: 10, weight: 0.4),
        TimeOfDayPreference(startHour: 5, endHour: 8, weight: 0.9),
      ];
      final r = evaluateTimeOfDayModifier(
        time: _at(7),
        preferences: overlapping,
      )!;
      // Max weight 0.9 wins → 0.7 + 0.9 * 0.8 = 1.42
      expect(r.value, closeTo(1.42, 1e-9));
    });
  });

  group('evaluateTimeOfDayModifier — midnight wrap', () {
    test('window 22→3 matches both 22:00 and 02:00', () {
      const overnight = [
        TimeOfDayPreference(startHour: 22, endHour: 3, weight: 0.7),
      ];
      // value = 0.7 + 0.7 * 0.8 = 1.26
      expect(
        evaluateTimeOfDayModifier(time: _at(22), preferences: overnight)!.value,
        closeTo(1.26, 1e-9),
      );
      expect(
        evaluateTimeOfDayModifier(time: _at(2), preferences: overnight)!.value,
        closeTo(1.26, 1e-9),
      );
      // 12:00 is outside the wrap window → outside-window penalty.
      expect(
        evaluateTimeOfDayModifier(time: _at(12), preferences: overnight)!.value,
        closeTo(0.4, 1e-9),
      );
    });

    test('wrap window inclusive on both ends', () {
      const overnight = [
        TimeOfDayPreference(startHour: 22, endHour: 3, weight: 0.7),
      ];
      expect(
        evaluateTimeOfDayModifier(time: _at(23), preferences: overnight)!.value,
        closeTo(1.26, 1e-9),
      );
      expect(
        evaluateTimeOfDayModifier(time: _at(3), preferences: overnight)!.value,
        closeTo(1.26, 1e-9),
      );
    });
  });

  group('evaluateTimeOfDayModifier — clamping', () {
    test('weight > 1.0 in species data is clamped before scaling', () {
      const overzealous = [
        TimeOfDayPreference(startHour: 6, endHour: 7, weight: 5.0),
      ];
      final r = evaluateTimeOfDayModifier(
        time: _at(6),
        preferences: overzealous,
      )!;
      // Clamps weight to 1.0 → 0.7 + 1.0 * 0.8 = 1.5
      expect(r.value, closeTo(1.5, 1e-9));
    });
  });
}

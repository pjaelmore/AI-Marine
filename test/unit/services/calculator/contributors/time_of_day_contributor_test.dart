import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/services/calculator/contributors/time_of_day_contributor.dart';
import 'package:flutter_test/flutter_test.dart';

/// Snook-flavored feeding windows: dawn (5–7 AM) strongly, dusk
/// (19–21) strongly, mid-morning (8–10) weakly. Mid-day is outside
/// every window.
const _snookWindows = [
  TimeOfDayPreference(startHour: 5, endHour: 7, weight: 0.9),
  TimeOfDayPreference(startHour: 8, endHour: 10, weight: 0.4),
  TimeOfDayPreference(startHour: 19, endHour: 21, weight: 0.85),
];

DateTime _at(int hour) => DateTime.utc(2026, 5, 22, hour);

void main() {
  group('evaluateTimeOfDayContributor — envelope', () {
    test('returns ContributorApplication with name and rangeMax', () {
      final r = evaluateTimeOfDayContributor(
        time: _at(6),
        preferences: _snookWindows,
      );
      expect(r.name, 'time_of_day');
      expect(r.rangeMax, 1.0);
    });
  });

  group('evaluateTimeOfDayContributor — window matching', () {
    test('hour inside the dawn window picks up its weight (0.9)', () {
      expect(
        evaluateTimeOfDayContributor(
          time: _at(6),
          preferences: _snookWindows,
        ).value,
        0.9,
      );
    });

    test('hour inside the dusk window picks up its weight (0.85)', () {
      expect(
        evaluateTimeOfDayContributor(
          time: _at(20),
          preferences: _snookWindows,
        ).value,
        0.85,
      );
    });

    test('hour inside a weaker mid-morning window picks up that weight', () {
      expect(
        evaluateTimeOfDayContributor(
          time: _at(9),
          preferences: _snookWindows,
        ).value,
        0.4,
      );
    });

    test('window bounds are inclusive on both ends', () {
      // 5 and 7 are both inside (5,7)
      expect(
        evaluateTimeOfDayContributor(
          time: _at(5),
          preferences: _snookWindows,
        ).value,
        0.9,
      );
      expect(
        evaluateTimeOfDayContributor(
          time: _at(7),
          preferences: _snookWindows,
        ).value,
        0.9,
      );
    });

    test('hour outside every window contributes 0', () {
      // Mid-day, between dawn cluster and dusk window.
      final r = evaluateTimeOfDayContributor(
        time: _at(13),
        preferences: _snookWindows,
      );
      expect(r.value, 0);
      expect(r.description, contains('Outside feeding windows'));
    });

    test('empty preferences list contributes 0 for any hour', () {
      for (final h in [0, 6, 12, 18, 23]) {
        expect(
          evaluateTimeOfDayContributor(
            time: _at(h),
            preferences: const [],
          ).value,
          0,
          reason: 'hour $h with no preferences should be 0',
        );
      }
    });
  });

  group('evaluateTimeOfDayContributor — overlapping windows', () {
    test('overlapping windows: highest weight wins (max, not sum)', () {
      const overlapping = [
        TimeOfDayPreference(startHour: 6, endHour: 10, weight: 0.4),
        TimeOfDayPreference(startHour: 5, endHour: 8, weight: 0.9),
      ];
      // 7 is inside both. Sum would be 1.3 (over rangeMax!). Max is 0.9.
      expect(
        evaluateTimeOfDayContributor(
          time: _at(7),
          preferences: overlapping,
        ).value,
        0.9,
      );
    });
  });

  group('evaluateTimeOfDayContributor — midnight wrap', () {
    test('window 22→3 matches both 22:00 and 02:00', () {
      const overnight = [
        TimeOfDayPreference(startHour: 22, endHour: 3, weight: 0.7),
      ];
      expect(
        evaluateTimeOfDayContributor(
          time: _at(22),
          preferences: overnight,
        ).value,
        0.7,
      );
      expect(
        evaluateTimeOfDayContributor(
          time: _at(2),
          preferences: overnight,
        ).value,
        0.7,
      );
      // 12:00 should be outside the 22→3 wrap window.
      expect(
        evaluateTimeOfDayContributor(
          time: _at(12),
          preferences: overnight,
        ).value,
        0,
      );
    });

    test('wrap window inclusive on both ends', () {
      const overnight = [
        TimeOfDayPreference(startHour: 22, endHour: 3, weight: 0.7),
      ];
      // 23 is in [22, 23] half; 3 is in [0, 3] half; both endpoints included.
      expect(
        evaluateTimeOfDayContributor(
          time: _at(23),
          preferences: overnight,
        ).value,
        0.7,
      );
      expect(
        evaluateTimeOfDayContributor(
          time: _at(3),
          preferences: overnight,
        ).value,
        0.7,
      );
    });
  });

  group('evaluateTimeOfDayContributor — clamping', () {
    test('weight > rangeMax in species data is clamped to rangeMax', () {
      const overzealous = [
        TimeOfDayPreference(startHour: 6, endHour: 7, weight: 5.0),
      ];
      expect(
        evaluateTimeOfDayContributor(
          time: _at(6),
          preferences: overzealous,
        ).value,
        1.0,
      );
    });
  });
}

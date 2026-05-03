import 'package:ai_marine_engine/core/utils/time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('weekOfYear', () {
    test('January 1 is in week 1', () {
      expect(weekOfYear(DateTime(2026, 1, 1)), 1);
    });

    test('January 7 is still in week 1 (7 days, 0-indexed)', () {
      expect(weekOfYear(DateTime(2026, 1, 7)), 1);
    });

    test('January 8 is in week 2', () {
      expect(weekOfYear(DateTime(2026, 1, 8)), 2);
    });

    test('mid-May lands in week 18-20 (striper spring run)', () {
      // Day 142 of a non-leap year = May 22.
      // (142 - 1) ~/ 7 + 1 = 21.
      expect(weekOfYear(DateTime(2026, 5, 22)), 21);
    });

    test('December 31 of a non-leap year clamps to week 52', () {
      expect(weekOfYear(DateTime(2026, 12, 31)), 52);
    });

    test('December 31 of a leap year clamps to week 52', () {
      expect(weekOfYear(DateTime(2024, 12, 31)), 52);
    });

    test('Feb 29 in a leap year is day 60 of the year', () {
      // (60 - 1) / 7 + 1 = 9.
      expect(weekOfYear(DateTime(2024, 2, 29)), 9);
    });

    test('March 1 stays in week 9 in both leap and non-leap years', () {
      // Non-leap March 1 is day 60; leap March 1 is day 61. Both still in
      // week 9 (days 57–63). The leap-year extra day shows up later as a
      // one-week shift past the next week boundary.
      expect(weekOfYear(DateTime(2026, 3, 1)), 9);
      expect(weekOfYear(DateTime(2024, 3, 1)), 9);
    });

    test('leap-year shift bumps March 4 from week 9 into week 10', () {
      // Non-leap March 4 = day 63 = week 9. Leap March 4 = day 64 = week 10.
      expect(weekOfYear(DateTime(2026, 3, 4)), 9);
      expect(weekOfYear(DateTime(2024, 3, 4)), 10);
    });

    test('result is always within 1..52', () {
      // Sweep every day of a leap year, every day of a non-leap year.
      for (final year in <int>[2024, 2026]) {
        var t = DateTime(year, 1, 1);
        final end = DateTime(year + 1, 1, 1);
        while (t.isBefore(end)) {
          final w = weekOfYear(t);
          expect(
            w,
            inInclusiveRange(1, 52),
            reason: '$t -> week $w out of range',
          );
          t = t.add(const Duration(days: 1));
        }
      }
    });
  });
}

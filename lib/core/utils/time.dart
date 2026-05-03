/// Week of the year (1..52) for the given [time].
///
/// Uses a simple day-of-year / 7 division rather than ISO 8601 week numbering.
/// The simpler scheme keeps the result indexed 1:1 into the 52-element weekly
/// arrays used by species data files; ISO numbering can yield 53 weeks in
/// some years and shifts week 1 across the previous year's December, neither
/// of which we want when looking up `weeklyValues[week - 1]`.
///
/// Day 1 (January 1) is in week 1. Day 8 (January 8) is in week 2. In leap
/// years, the trailing days of the year clamp to week 52.
int weekOfYear(DateTime time) {
  final doy = _dayOfYear(time);
  return (((doy - 1) ~/ 7) + 1).clamp(1, 52);
}

/// 1-indexed day of the year for [time], handling leap years correctly.
/// Computed via direct date arithmetic so daylight-savings transitions
/// don't perturb the result by a day.
int _dayOfYear(DateTime time) {
  const daysBeforeMonth = <int>[
    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334,
  ];
  var doy = daysBeforeMonth[time.month - 1] + time.day;
  if (time.month > 2 && _isLeapYear(time.year)) doy += 1;
  return doy;
}

bool _isLeapYear(int year) =>
    (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

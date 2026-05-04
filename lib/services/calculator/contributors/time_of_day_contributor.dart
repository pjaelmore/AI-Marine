import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

/// Maximum value a time-of-day match can add. The contributor is
/// additive on the final 0–10 score, so 1.0 means a perfect feeding-
/// window match can add up to one whole point on the user-facing
/// scale — meaningful but not dominant.
const double _timeOfDayRangeMax = 1.0;

/// Additive time-of-day contributor (TDD §6).
///
/// Looks up [time]'s hour against the species's
/// [ConditionProfile.timeOfDayPreferences]. The weight of the highest-
/// matching window is the contribution value, in `[0, _timeOfDayRangeMax]`.
/// No matching window → 0 (the contributor adds nothing rather than
/// penalizing — that's what contributors are for).
///
/// **Multiple overlapping windows: max wins.** Summing would let
/// poorly-tuned species data with redundant windows escalate above
/// the documented `rangeMax`; max preserves the envelope.
///
/// **Midnight wrap.** A window with `endHour < startHour` wraps
/// midnight — `(start: 22, end: 3)` covers `[22, 23] ∪ [0, 3]`.
/// Night-feeding species (e.g. snook around docks under lights) use
/// this. The hour comparison is inclusive on both ends.
ContributorApplication evaluateTimeOfDayContributor({
  required DateTime time,
  required List<TimeOfDayPreference> preferences,
}) {
  final hour = time.hour;
  double bestWeight = 0;
  TimeOfDayPreference? bestMatch;
  for (final pref in preferences) {
    if (!_hourInWindow(hour, pref.startHour, pref.endHour)) continue;
    if (pref.weight > bestWeight) {
      bestWeight = pref.weight;
      bestMatch = pref;
    }
  }
  final value = bestWeight.clamp(0.0, _timeOfDayRangeMax);

  return ContributorApplication(
    name: 'time_of_day',
    value: value,
    rangeMax: _timeOfDayRangeMax,
    description: bestMatch == null
        ? 'Outside feeding windows (hour ${_hh(hour)})'
        : 'Hour ${_hh(hour)} inside feeding window '
            '${_hh(bestMatch.startHour)}–${_hh(bestMatch.endHour)}',
  );
}

bool _hourInWindow(int hour, int startHour, int endHour) {
  if (endHour >= startHour) {
    return hour >= startHour && hour <= endHour;
  }
  // Midnight wrap: window covers [start..23] ∪ [0..end].
  return hour >= startHour || hour <= endHour;
}

String _hh(int h) => h.toString().padLeft(2, '0');

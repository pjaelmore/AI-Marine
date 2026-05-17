import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

/// Modifier envelope per TDD §6.5 — `[0, 2]` with neutral at 1.0.
const double _modifierMin = 0.0;
const double _modifierMax = 2.0;

/// Penalty floor for "outside every known feeding window." Not zero
/// (a zero modifier would nuke the geometric mean and tell a user
/// "absolutely no fish here" off a single noisy signal); not neutral
/// (the whole reason this is a modifier and not a contributor is
/// that the wrong time of day should drag the score down). 0.4
/// drops a 5.0 raw score to roughly 3.5, which is what the heatmap
/// wants for "diurnal species, after dark."
const double _outsideWindowFloor = 0.4;

/// Multiplicative time-of-day modifier (TDD §6).
///
/// Looks up [time]'s hour against the species's
/// [ConditionProfile.timeOfDayPreferences] and returns a modifier in
/// `[0, 2]`:
///
///   - **Inside** the best-matching window: scaled from the window's
///     weight to `[0.7, 1.5]` — weight 0 → 0.7 (mild drag if the
///     species curator marked the window inactive), weight 1.0 → 1.5
///     (boost). Inside a window can never be worse than outside.
///   - **Outside** every window: [_outsideWindowFloor] = 0.4. Drags
///     the geometric mean down meaningfully but doesn't zero it.
///   - **Empty preferences list**: returns null. The caller omits
///     the modifier from the breakdown — same contract as the
///     missing-data path for water-temp / wind / etc. (TDD §2.1.3).
///
/// **Why this was promoted from a contributor**: contributors only
/// add to the score; missing a feeding window meant "no bonus" rather
/// than "wrong time of day, expect less." Diurnal species (mahi,
/// snapper) were scoring full marks at midnight because nothing in
/// the math knew that mattered. As a modifier, time-of-day finally
/// pushes back.
///
/// **Midnight wrap.** A window with `endHour < startHour` wraps
/// midnight — `(start: 22, end: 3)` covers `[22, 23] ∪ [0, 3]`.
/// Night-feeding species (e.g. snook around dock lights) use this.
///
/// **Multiple overlapping windows: max wins.** Mirrors the prior
/// contributor's behavior — summing would let poorly-tuned species
/// data with redundant windows escalate above `rangeMax`.
ModifierApplication? evaluateTimeOfDayModifier({
  required DateTime time,
  required List<TimeOfDayPreference> preferences,
}) {
  if (preferences.isEmpty) return null;

  final hour = time.hour;
  double bestWeight = 0;
  TimeOfDayPreference? bestMatch;
  for (final pref in preferences) {
    if (!_hourInWindow(hour, pref.startHour, pref.endHour)) continue;
    if (bestMatch == null || pref.weight > bestWeight) {
      bestWeight = pref.weight;
      bestMatch = pref;
    }
  }

  final double value;
  final String description;
  if (bestMatch == null) {
    value = _outsideWindowFloor;
    description = 'Outside feeding windows (hour ${_hh(hour)})';
  } else {
    final w = bestWeight.clamp(0.0, 1.0);
    value = 0.7 + w * 0.8;
    description = 'Hour ${_hh(hour)} inside feeding window '
        '${_hh(bestMatch.startHour)}–${_hh(bestMatch.endHour)} '
        '(weight ${w.toStringAsFixed(2)})';
  }

  return ModifierApplication(
    name: 'time_of_day',
    value: value,
    rangeMin: _modifierMin,
    rangeMax: _modifierMax,
    description: description,
  );
}

bool _hourInWindow(int hour, int startHour, int endHour) {
  if (endHour >= startHour) {
    return hour >= startHour && hour <= endHour;
  }
  return hour >= startHour || hour <= endHour;
}

String _hh(int h) => h.toString().padLeft(2, '0');

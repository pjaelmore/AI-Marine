import 'dart:math' as math;

import '../../../core/types/catch_record.dart';
import '../../../core/types/score_result.dart';

const double _recentCatchesRangeMax = 1.0;

/// Half-life for the recency exponential. A catch this old contributes
/// half what a catch right now would. 14 days is the v1 default —
/// fish behavior repeats seasonally so older reports retain *some*
/// signal, but a fresh catch is much stronger evidence of "this spot
/// is producing right now." Tuneable via calibration tuples in a
/// later slice.
const double _recencyHalfLifeDays = 14.0;

/// Additive recent-catches-nearby contributor (TDD §6).
///
/// Closes the personal-history feedback loop: the catch log feeds
/// back into the score so a spot the user has been working
/// successfully scores higher than an unfished neighbor.
///
/// Formula: each catch contributes `exp(-ln2 × days_old / half_life)`,
/// summed and clamped to `[0, _recentCatchesRangeMax]`. Exponential
/// decay (vs linear) means very-old catches taper smoothly toward
/// zero rather than dropping off a cliff at an arbitrary cutoff.
///
/// **Filtering is the caller's job.** This function trusts that
/// [recentCatches] has already been narrowed by location radius,
/// species, and a `since` cutoff (the conditions service's
/// `getRecentCatches` method does exactly that). Passing in
/// unfiltered catches will silently inflate the contribution.
ContributorApplication evaluateRecentCatchesContributor({
  required List<CatchRecord> recentCatches,
  required DateTime referenceTime,
}) {
  if (recentCatches.isEmpty) {
    return const ContributorApplication(
      name: 'recent_catches',
      value: 0,
      rangeMax: _recentCatchesRangeMax,
      description: 'No recent catches in the search area',
    );
  }

  // Decay constant so exp(-k × halfLifeDays) = 0.5.
  const k = math.ln2 / _recencyHalfLifeDays;
  var sum = 0.0;
  for (final c in recentCatches) {
    final daysOld =
        referenceTime.difference(c.timestamp).inHours / Duration.hoursPerDay;
    if (daysOld < 0) continue; // future-stamped catches are noise; skip.
    sum += math.exp(-k * daysOld);
  }
  final value = sum.clamp(0.0, _recentCatchesRangeMax);

  return ContributorApplication(
    name: 'recent_catches',
    value: value,
    rangeMax: _recentCatchesRangeMax,
    description: '${recentCatches.length} recent '
        '${recentCatches.length == 1 ? 'catch' : 'catches'} '
        'in the search area',
  );
}

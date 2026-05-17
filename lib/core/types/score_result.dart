import 'package:freezed_annotation/freezed_annotation.dart';

import 'lat_lng.dart';

part 'score_result.freezed.dart';
part 'score_result.g.dart';

/// One gate's pass/fail outcome. TDD §3.5.
@freezed
class GateResult with _$GateResult {
  const factory GateResult({
    required String name,
    required bool passed,
    String? failureReason,
  }) = _GateResult;

  factory GateResult.fromJson(Map<String, dynamic> json) =>
      _$GateResultFromJson(json);
}

/// One modifier's contribution to the multiplicative product. [value] is
/// the multiplier (>1 boosts, <1 dampens, ==1 neutral); [rangeMin] and
/// [rangeMax] frame the bar visualisation in the recommendation card.
///
/// **[available] = false** marks a modifier that surfaces in the breakdown
/// for transparency but **is excluded from the geometric mean**. Used when
/// a sensor returned `DataSource.unavailable` (no NDBC station in range,
/// no bathymetry, etc.) — the calculator emits a placeholder row so the
/// user can see *what data is missing* rather than the calculator silently
/// dropping the dimension. TDD §2.1.3 says "skip the modifier" — that
/// rule was about not penalizing with a fake neutral 1.0, not about
/// hiding the gap from the user.
@freezed
class ModifierApplication with _$ModifierApplication {
  const factory ModifierApplication({
    required String name,
    required double value,
    required double rangeMin,
    required double rangeMax,
    required String description,
    @Default(true) bool available,

    /// When the underlying observation was recorded — sourced from the
    /// `ConditionResult.observedAt` that fed this modifier. Surfaced
    /// in the recommendation card as an "Observed HH:mm UTC" subtitle
    /// so the user knows whether a reading is fresh or 50 minutes old
    /// (NDBC's 10-minute realtime2 cadence makes this material). Null
    /// for derived/computed modifiers (time-of-day, solunar) and for
    /// the unavailable placeholders.
    DateTime? observedAt,
  }) = _ModifierApplication;

  factory ModifierApplication.fromJson(Map<String, dynamic> json) =>
      _$ModifierApplicationFromJson(json);
}

/// One contributor's additive contribution. [value] is in [0, rangeMax];
/// the recommendation card renders only contributors with value > 0.
@freezed
class ContributorApplication with _$ContributorApplication {
  const factory ContributorApplication({
    required String name,
    required double value,
    required double rangeMax,
    required String description,
  }) = _ContributorApplication;

  factory ContributorApplication.fromJson(Map<String, dynamic> json) =>
      _$ContributorApplicationFromJson(json);
}

/// Full transparency record for a score: every gate, every modifier,
/// every contributor that fed into the final number. Mirrors TDD §3.5.
///
/// This is the structure the "Why this score" panel renders against
/// (TDD §10.3.2) — the application's principal trust-building surface.
@freezed
class ReasoningBreakdown with _$ReasoningBreakdown {
  const factory ReasoningBreakdown({
    required double baseProbability,
    required List<GateResult> gates,
    required List<ModifierApplication> modifiers,
    required List<ContributorApplication> contributors,
    required double rawScoreBeforeContributors,
    required double additiveTotal,
    required double finalScore,
    required String migrationSummary,
    required String suggestedApproach,
  }) = _ReasoningBreakdown;

  factory ReasoningBreakdown.fromJson(Map<String, dynamic> json) =>
      _$ReasoningBreakdownFromJson(json);
}

/// The output of `ProbabilityCalculator.scoreLocation` (TDD §6.5) and
/// each cell of `scoreGrid` (TDD §6.7).
///
/// TDD §3.5 defines `ReasoningBreakdown` but does not separately define
/// `ScoreResult` as a class — the shape is inferred from the construction
/// site at TDD §6.5 lines 1743–1760, which carries species, location,
/// time, the final 0–10 score, an aggregate confidence, and the full
/// reasoning. Same kind of spec gap as `NamedFeature` in §3.2 and handled
/// the same way: minimal inferred shape, documented inline.
@freezed
class ScoreResult with _$ScoreResult {
  const factory ScoreResult({
    required String speciesId,
    required LatLng location,
    required DateTime time,
    required double finalScore,
    required double confidence,
    required ReasoningBreakdown reasoning,
  }) = _ScoreResult;

  factory ScoreResult.fromJson(Map<String, dynamic> json) =>
      _$ScoreResultFromJson(json);
}

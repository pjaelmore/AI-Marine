import 'dart:math' as math;

import '../../core/types/condition_result.dart';
import '../../core/types/lat_lng.dart';
import '../../core/types/score_result.dart';
import '../../data/species/models/species_record.dart';
import '../conditions/conditions_service.dart';
import 'contributors/recent_catches_contributor.dart';
import 'contributors/structure_proximity_contributor.dart';
import 'contributors/time_of_day_contributor.dart';
import 'migration_base_probability.dart';
import 'migration_gate.dart';
import 'modifiers/barometric_trend_modifier.dart';
import 'modifiers/solunar_window_modifier.dart';
import 'modifiers/tide_phase_modifier.dart';
import 'modifiers/water_temp_modifier.dart';
import 'modifiers/wind_speed_modifier.dart';

/// Final user-facing score scale per TDD §6.5: 0 (no chance) to 10
/// (this is where the fish are right now).
const double _scoreScaleMax = 10.0;

/// Modifier value envelope — each modifier returns a multiplier in
/// `[0, 2]` with neutral at 1.0. Used to scale the geometric mean of
/// modifiers onto the user-facing 0–10 score.
const double _modifierEnvelopeMax = 2.0;

/// How far back recent-catches looks. 60 days well past the
/// 14-day half-life used inside the contributor (a 60-day-old catch
/// contributes < 5%); going farther just loads more rows for
/// vanishing return.
const Duration _recentCatchesWindow = Duration(days: 60);

/// Search radius for recent-catches "is there a fishing report
/// near here." 1 nm is roughly the user's working area on any
/// given session.
const double _recentCatchesRadiusNm = 1.0;

/// Scores a single location for a single species at a single time
/// — TDD §6.5.
///
/// **Math:**
/// ```
/// gates → either pass (continue) or fail (final = 0)
/// base = base probability from migration model       → [0, 1]
/// gm   = geometric mean of available modifiers       → [0, 2]
/// raw  = base × gm × 5                               → [0, 10]
/// add  = sum of contributors                         → [0, ~3]
/// final = clamp(raw + add, 0, 10)                    → [0, 10]
/// ```
///
/// **Why geometric mean (not raw product) of modifiers:** the score
/// range stays N-independent. Adding a sixth modifier later doesn't
/// blow out the saturation point or require re-balancing the
/// contributors — `gm` is always in [0, 2] regardless of how many
/// modifiers fed in. A single zero modifier still nukes the score
/// (gm of zero is zero), which is the desired behavior for fatal
/// conditions like water-temp-out-of-range or small-craft wind.
///
/// **Missing data is "skip the modifier", not "penalty"** (TDD
/// §2.1.3). When a `ConditionsService` method returns
/// `DataSource.unavailable`, the orchestrator omits that modifier
/// from the geometric mean and from the breakdown. A station outage
/// degrades transparency but doesn't tank the score.
class ProbabilityCalculator {
  ProbabilityCalculator({required this.conditions});

  final ConditionsService conditions;

  Future<ScoreResult> scoreLocation({
    required SpeciesRecord species,
    required LatLng location,
    required DateTime time,
  }) async {
    // ── 1. Migration gate ─────────────────────────────────────────
    final gate = evaluateMigrationGate(
      migration: species.migrationModel,
      location: location,
      time: time,
    );
    if (!gate.passed) {
      return ScoreResult(
        speciesId: species.id,
        location: location,
        time: time,
        finalScore: 0,
        confidence: 1, // we're confident the species isn't here
        reasoning: ReasoningBreakdown(
          baseProbability: 0,
          gates: [gate],
          modifiers: const [],
          contributors: const [],
          rawScoreBeforeContributors: 0,
          additiveTotal: 0,
          finalScore: 0,
          migrationSummary: gate.failureReason ?? 'Migration gate failed',
          suggestedApproach: 'Try a different location or time of year.',
        ),
      );
    }

    // ── 2. Base probability ───────────────────────────────────────
    final base = calculateMigrationBaseProbability(
      migration: species.migrationModel,
      location: location,
      time: time,
    );

    // ── 3. Fetch every condition the modifiers / contributors need.
    // Kick off all futures up front so they run in parallel; await
    // each individually to preserve the typed ConditionResult<T> the
    // modifier signatures need. The cache layer absorbs duplicate
    // adapter calls so this is cheap on a warm session.
    final waterTempF = conditions.getWaterTemp(location, time);
    final tideF = conditions.getTideState(location, time);
    final windF = conditions.getWind(location, time);
    final baroF = conditions.getBarometric(location, time);
    final solunarF = conditions.getSolunar(location, time);
    final structureF = conditions.getStructure(location);
    final catchesF = conditions.getRecentCatches(
      location,
      _recentCatchesRadiusNm,
      speciesId: species.id,
      since: time.subtract(_recentCatchesWindow),
    );

    final waterTemp = await waterTempF;
    final tide = await tideF;
    final wind = await windF;
    final baro = await baroF;
    final solunar = await solunarF;
    final structure = await structureF;
    final catches = await catchesF;

    // ── 4. Modifiers — skip any whose input is unavailable. ────────
    final modifiers = <ModifierApplication>[];
    final modifierConfidences = <double>[];

    if (waterTemp.source != DataSource.unavailable) {
      modifiers.add(
        evaluateWaterTempModifier(
          waterTempF: waterTemp.value,
          optimalTemp: species.conditionProfile.optimalTemp,
          toleratedTemp: species.conditionProfile.toleratedTemp,
        ),
      );
      modifierConfidences.add(waterTemp.confidence);
    }

    if (tide.source != DataSource.unavailable) {
      modifiers.add(
        evaluateTidePhaseModifier(
          phase: tide.value.phase,
          preference: species.conditionProfile.tidePreference,
        ),
      );
      modifierConfidences.add(tide.confidence);
    }

    if (wind.source != DataSource.unavailable) {
      modifiers.add(evaluateWindSpeedModifier(wind: wind.value));
      modifierConfidences.add(wind.confidence);
    }

    if (baro.source != DataSource.unavailable) {
      modifiers.add(
        evaluateBarometricTrendModifier(
          barometric: baro.value,
          sensitivity: species.conditionProfile.weatherSensitivity,
        ),
      );
      modifierConfidences.add(baro.confidence);
    }

    if (solunar.source != DataSource.unavailable) {
      modifiers.add(
        evaluateSolunarWindowModifier(
          solunar: solunar.value,
          sensitivity: species.conditionProfile.solunarSensitivity,
          time: time,
        ),
      );
      modifierConfidences.add(solunar.confidence);
    }

    // Geometric mean of modifier values, scaled to the 0–10 envelope.
    final double geometricMean;
    if (modifiers.isEmpty) {
      geometricMean = 1.0; // no signal → neutral
    } else {
      var product = 1.0;
      for (final m in modifiers) {
        product *= m.value;
      }
      geometricMean = math.pow(product, 1.0 / modifiers.length).toDouble();
    }
    final rawScore =
        base * geometricMean * (_scoreScaleMax / _modifierEnvelopeMax);

    // ── 5. Contributors — additive bonuses. ────────────────────────
    final contributors = <ContributorApplication>[
      evaluateTimeOfDayContributor(
        time: time,
        preferences: species.conditionProfile.timeOfDayPreferences,
      ),
      // Structure: getStructure returns unavailable today (Phase 7+),
      // but we still surface the row in the breakdown with value 0
      // and a "type unknown" description — transparency over silence.
      if (structure.source != DataSource.unavailable)
        evaluateStructureProximityContributor(
          structure: structure.value,
          preferences: species.conditionProfile.structurePreferences,
        ),
      evaluateRecentCatchesContributor(
        recentCatches: catches,
        referenceTime: time,
      ),
    ];
    final additiveTotal =
        contributors.fold<double>(0, (sum, c) => sum + c.value);

    // ── 6. Final score and confidence. ─────────────────────────────
    final finalScore = (rawScore + additiveTotal).clamp(0.0, _scoreScaleMax);
    final confidence = modifierConfidences.isEmpty
        ? 0.0
        : modifierConfidences.reduce((a, b) => a + b) /
            modifierConfidences.length;

    return ScoreResult(
      speciesId: species.id,
      location: location,
      time: time,
      finalScore: finalScore,
      confidence: confidence,
      reasoning: ReasoningBreakdown(
        baseProbability: base,
        gates: [gate],
        modifiers: modifiers,
        contributors: contributors,
        rawScoreBeforeContributors: rawScore,
        additiveTotal: additiveTotal,
        finalScore: finalScore,
        migrationSummary: 'Species present at base probability '
            '${(base * 100).toStringAsFixed(0)}% for week '
            '${_weekHint(time)}.',
        suggestedApproach: _approachHint(modifiers, contributors),
      ),
    );
  }

  /// Scores a regular grid of locations across [bbox] at the given
  /// [resolutionNm] resolution — TDD §6.7. Powers the heatmap layer
  /// in Phase 6.
  ///
  /// The grid is laid out as cell centers spaced [resolutionNm]
  /// apart along each axis, with the first cell centered half a
  /// step inside the southwest corner. Cells outside the species's
  /// spatial range still appear in the result with `finalScore = 0`
  /// — that's useful "no fish here" data for the heatmap.
  ///
  /// **Sequential execution** in v1: the four-tier cache absorbs
  /// duplicate condition fetches across cells (most cells in a
  /// reasonable bbox resolve to the same NDBC station / NWS zone),
  /// so the second cell onward is cache-warm. Parallel dispatch is
  /// a Phase 6+ optimization once the heatmap UI exists and
  /// measurable perf data exists to tune against.
  ///
  /// Caller is responsible for sane inputs. A bbox covering all of
  /// Florida at 0.1 nm resolution would generate ~30M cells — the
  /// function won't reject it but the UI will hang. Phase 6 will
  /// pick sensible defaults (typical fishing-spot grid is 5–10 nm
  /// at ~0.5 nm resolution → ~100–400 cells).
  Future<List<ScoreResult>> scoreGrid({
    required SpeciesRecord species,
    required LatLngBounds bbox,
    required DateTime time,
    required double resolutionNm,
  }) async {
    assert(resolutionNm > 0, 'resolutionNm must be positive');
    final rows = (bbox.heightNm / resolutionNm).ceil().clamp(1, 1000);
    final cols = (bbox.widthNm / resolutionNm).ceil().clamp(1, 1000);
    final latStep = (bbox.northeast.latitude - bbox.southwest.latitude) / rows;
    final lngStep =
        (bbox.northeast.longitude - bbox.southwest.longitude) / cols;

    final results = <ScoreResult>[];
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        final lat = bbox.southwest.latitude + (i + 0.5) * latStep;
        final lng = bbox.southwest.longitude + (j + 0.5) * lngStep;
        final cell = LatLng(latitude: lat, longitude: lng);
        results.add(
          await scoreLocation(species: species, location: cell, time: time),
        );
      }
    }
    return results;
  }

  String _weekHint(DateTime time) {
    final start = DateTime.utc(time.toUtc().year);
    final daysIn = time.toUtc().difference(start).inDays;
    return '${(daysIn ~/ 7) + 1}';
  }

  /// Best-effort one-line approach suggestion built from the strongest
  /// signals in the breakdown. Replaced by species-data-driven prose
  /// in a future slice.
  String _approachHint(
    List<ModifierApplication> modifiers,
    List<ContributorApplication> contributors,
  ) {
    final strongMods = modifiers
        .where((m) => m.value >= 1.5)
        .map((m) => m.name.replaceAll('_', ' '))
        .toList();
    final strongContribs = contributors
        .where((c) => c.value >= 0.5)
        .map((c) => c.name.replaceAll('_', ' '))
        .toList();
    final all = [...strongMods, ...strongContribs];
    if (all.isEmpty) {
      return 'Conditions are mediocre across the board; '
          'consider a different time or spot.';
    }
    return 'Strong signals: ${all.join(', ')}.';
  }
}

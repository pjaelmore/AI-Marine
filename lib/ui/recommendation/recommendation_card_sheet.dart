import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/types/score_result.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'contributor_bar_tile.dart';
import 'gate_row.dart';
import 'math_block.dart';
import 'modifier_bar_tile.dart';
import 'sheet_chrome.dart';
import 'suggested_approach_block.dart';

/// Bottom-sheet recommendation card — the project's defensibility surface.
///
/// Anchored to the chart bottom; two snap points (peek ~30%, expanded
/// ~85%) per the locked Phase 6 decision. The user pans the chart, taps
/// a spot, sees the score with reasoning, dismisses, taps another spot.
/// Spatial context is preserved which the recommendation is *for*.
///
/// Body order: header → gates → modifiers (boosting / dampening /
/// unverified) → contributors → math block → suggested approach. Loading
/// / error / empty states are sibling widgets the chart shell swaps in,
/// not modes of this card.
class RecommendationCardSheet extends StatelessWidget {
  const RecommendationCardSheet({
    super.key,
    required this.result,
    this.onClose,
    this.unverifiedModifierNames = const <String>{},
  });

  /// Score to render. Null is the caller's responsibility to handle —
  /// the card assumes a real result and won't render a "no spot
  /// selected" state. The chart shell hides the sheet when no spot
  /// is tapped.
  final ScoreResult result;

  /// Optional dismiss callback wired by the chart shell. When null,
  /// the close button is omitted so the sheet stays purely a passive
  /// renderer (useful for previews and tests).
  final VoidCallback? onClose;

  /// Modifier names whose underlying species data is marked
  /// `unverified` in `dataProvenance`. Sourced by the chart shell
  /// from `SpeciesRecord.dataProvenance` and passed in here so the
  /// card itself stays decoupled from species data plumbing. The
  /// modifier subsection routes these to a muted "UNVERIFIED" row
  /// instead of the bar.
  final Set<String> unverifiedModifierNames;

  /// Initial sheet position as a fraction of the screen. Matches the
  /// "peek" snap point — header + label visible, chart still readable
  /// above.
  static const double peekSize = 0.32;

  /// Lower bound — the user can collapse the sheet but it never goes
  /// below the peek size. Falling further would just hide content
  /// without affordance.
  static const double minSize = 0.32;

  /// Expanded snap point — leaves a chart sliver at the top so the
  /// user knows the chart is still there.
  static const double maxSize = 0.88;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: peekSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      snap: true,
      snapSizes: const [peekSize, maxSize],
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: MarineColors.surfaceElevated,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(MarineSpacing.radiusLg),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 24,
                offset: Offset(0, -6),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(
              MarineSpacing.xl,
              MarineSpacing.md,
              MarineSpacing.xl,
              MarineSpacing.xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SheetGrabber(),
                const SizedBox(height: MarineSpacing.md),
                _Header(result: result, onClose: onClose),
                const SizedBox(height: MarineSpacing.lg),
                _GatesBlock(gates: result.reasoning.gates),
                const SizedBox(height: MarineSpacing.lg),
                _ModifiersBlock(
                  result: result,
                  unverifiedNames: unverifiedModifierNames,
                ),
                const SizedBox(height: MarineSpacing.lg),
                _ContributorsBlock(
                  contributors: result.reasoning.contributors,
                ),
                const SizedBox(height: MarineSpacing.lg),
                const _SectionLabel('The math'),
                MathBlock(reasoning: result.reasoning),
                const SizedBox(height: MarineSpacing.lg),
                SuggestedApproachBlock(
                  approach: result.reasoning.suggestedApproach,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Score block + species/location/time + confidence indicator. Only
/// piece visible at the peek snap point alongside the grabber.
class _Header extends StatelessWidget {
  const _Header({required this.result, this.onClose});

  final ScoreResult result;
  final VoidCallback? onClose;

  static final _timeFormatter = DateFormat('MMM d, h:mm a');

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ScoreBlock(score: result.finalScore),
        const SizedBox(width: MarineSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatSpecies(result.speciesId),
                style: MarineTypography.headingSmall,
              ),
              const SizedBox(height: MarineSpacing.xs),
              Text(
                _formatLocationTime(result),
                style: MarineTypography.bodySmall.copyWith(
                  color: MarineColors.onDark.withAlpha(160),
                ),
              ),
              const SizedBox(height: MarineSpacing.sm),
              _ConfidenceChip(confidence: result.confidence),
            ],
          ),
        ),
        if (onClose != null)
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: onClose,
            tooltip: 'Dismiss',
          ),
      ],
    );
  }

  /// Turn `common-snook` into `Common snook` for the header. v1 uses
  /// the species id; a later slice can swap in a localized common-name
  /// lookup once the species picker UI exists.
  String _formatSpecies(String id) {
    if (id.isEmpty) return id;
    final spaced = id.replaceAll('-', ' ');
    return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
  }

  String _formatLocationTime(ScoreResult r) {
    final lat = r.location.latitude.toStringAsFixed(2);
    final lng = r.location.longitude.toStringAsFixed(2);
    final time = _timeFormatter.format(r.time.toLocal());
    return '$lat°N, $lng° · $time';
  }
}

/// The big score numeral. Action-teal background, score in tabular
/// figures so it doesn't reflow as the value updates.
class _ScoreBlock extends StatelessWidget {
  const _ScoreBlock({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: const BoxDecoration(
        color: MarineColors.actionTeal,
        borderRadius: BorderRadius.all(Radius.circular(MarineSpacing.radiusMd)),
      ),
      alignment: Alignment.center,
      child: Text(
        score.toStringAsFixed(score >= 9.95 ? 0 : 1),
        style: MarineTypography.cardScoreNumeral.copyWith(fontSize: 38),
      ),
    );
  }
}

/// Compact confidence indicator below the species line.
class _ConfidenceChip extends StatelessWidget {
  const _ConfidenceChip({required this.confidence});

  final double confidence;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: MarineColors.actionTeal,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: MarineSpacing.xs),
        Text(
          'Confidence ${confidence.toStringAsFixed(2)}',
          style: MarineTypography.label.copyWith(
            color: MarineColors.actionTeal,
          ),
        ),
      ],
    );
  }
}

/// Gates section — at the top of the breakdown. Renders one [GateRow]
/// per [GateResult]. When all gates pass this is a row of green pills;
/// when one fails it surfaces the failure reason and (because a failed
/// gate produces `finalScore = 0` with empty modifiers/contributors)
/// becomes the *only* explanation the user gets.
class _GatesBlock extends StatelessWidget {
  const _GatesBlock({required this.gates});

  final List<GateResult> gates;

  @override
  Widget build(BuildContext context) {
    if (gates.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionLabel('Gates'),
        ...gates.map((g) => GateRow(gate: g)),
      ],
    );
  }
}

/// Contributors section — additive bonuses on top of the multiplied
/// base × modifiers product. Section appears even when every
/// contributor is zero so the user sees what *could* contribute (a
/// gentle nudge to log catches feeds the recent-catches contributor;
/// a structure bonus comes from species data + ENC bathymetry).
class _ContributorsBlock extends StatelessWidget {
  const _ContributorsBlock({required this.contributors});

  final List<ContributorApplication> contributors;

  @override
  Widget build(BuildContext context) {
    if (contributors.isEmpty) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionLabel("What's adding"),
          _SectionLabel('No contributors fired (data unavailable)'),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionLabel("What's adding"),
        ...contributors.map((c) => ContributorBarTile(contributor: c)),
      ],
    );
  }
}

/// Modifiers section — splits boosting / dampening / unverified into
/// labelled subsections. Boosting (value > 1) appears first because
/// it's what the user came to learn ("why is this spot good?"); the
/// dampening section explains the ceiling; unverified rows surface
/// last so the user sees what *isn't* peer-reviewed.
class _ModifiersBlock extends StatelessWidget {
  const _ModifiersBlock({
    required this.result,
    required this.unverifiedNames,
  });

  final ScoreResult result;
  final Set<String> unverifiedNames;

  @override
  Widget build(BuildContext context) {
    final boosting = <ModifierApplication>[];
    final dampening = <ModifierApplication>[];
    final unverified = <ModifierApplication>[];
    for (final m in result.reasoning.modifiers) {
      if (unverifiedNames.contains(m.name)) {
        unverified.add(m);
      } else if (m.value >= 1.0) {
        boosting.add(m);
      } else {
        dampening.add(m);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (boosting.isNotEmpty) ...[
          const _SectionLabel("What's boosting"),
          ...boosting.map((m) => ModifierBarTile(modifier: m)),
        ],
        if (dampening.isNotEmpty) ...[
          const _SectionLabel("What's dampening"),
          ...dampening.map((m) => ModifierBarTile(modifier: m)),
        ],
        if (unverified.isNotEmpty) ...[
          const _SectionLabel('Tracked but unverified'),
          ...unverified.map(
            (m) => ModifierBarTile(modifier: m, unverified: true),
          ),
        ],
        if (boosting.isEmpty && dampening.isEmpty && unverified.isEmpty)
          const _SectionLabel('No modifiers fired (data unavailable)'),
      ],
    );
  }
}

/// Small all-caps label that introduces each modifier subsection.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MarineSpacing.sm),
      child: Text(
        text.toUpperCase(),
        style: MarineTypography.label.copyWith(
          color: MarineColors.onDark.withAlpha(160),
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

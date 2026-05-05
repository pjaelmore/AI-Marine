import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/types/score_result.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// Bottom-sheet recommendation card — the project's defensibility surface.
///
/// Anchored to the chart bottom; two snap points (peek ~30%, expanded
/// ~85%) per the locked Phase 6 decision. The user pans the chart, taps
/// a spot, sees the score with reasoning, dismisses, taps another spot.
/// Spatial context is preserved which the recommendation is *for*.
///
/// **Scaffold scope (this slice):** layout structure + score header +
/// placeholder body. Sibling slices fill in the modifier bars,
/// contributor bars, gates row, math block, and suggested approach —
/// each landing as its own focused commit.
class RecommendationCardSheet extends StatelessWidget {
  const RecommendationCardSheet({
    super.key,
    required this.result,
    this.onClose,
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
                const _Grabber(),
                const SizedBox(height: MarineSpacing.md),
                _Header(result: result, onClose: onClose),
                const SizedBox(height: MarineSpacing.lg),
                const _BreakdownPlaceholder(),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// The horizontal pill at the top of the sheet that signals draggability.
class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44,
        height: 4,
        decoration: const BoxDecoration(
          color: MarineColors.divider,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
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

/// Stand-in for the breakdown body. Replaced in the next slices with
/// modifier bars, contributor bars, gates row, math block, and approach.
class _BreakdownPlaceholder extends StatelessWidget {
  const _BreakdownPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MarineSpacing.lg),
      decoration: BoxDecoration(
        color: MarineColors.deepMarine,
        borderRadius: BorderRadius.circular(MarineSpacing.radiusMd),
        border: Border.all(color: MarineColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BREAKDOWN',
            style: MarineTypography.label.copyWith(
              color: MarineColors.onDark.withAlpha(150),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: MarineSpacing.sm),
          Text(
            'Modifier bars, contributor bars, gates row, math block, and '
            'suggested approach land in upcoming slices.',
            style: MarineTypography.bodySmall.copyWith(
              color: MarineColors.onDark.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}

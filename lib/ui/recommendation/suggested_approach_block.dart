import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// Teal-bordered callout at the bottom of the recommendation card body.
/// Renders the species/spec-derived "what to actually do" guidance from
/// [ReasoningBreakdown.suggestedApproach] (e.g. "Live pinfish on the
/// channel edge — falling tide drains bait off the flats").
///
/// Visually distinct from the math block (which is the *why*) — this
/// is the *now what*. Left-border accent + teal-tinted background reuse
/// the action-teal hue so the user reads it as actionable, not
/// informational.
class SuggestedApproachBlock extends StatelessWidget {
  const SuggestedApproachBlock({super.key, required this.approach});

  final String approach;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        MarineSpacing.lg,
        MarineSpacing.md,
        MarineSpacing.lg,
        MarineSpacing.md,
      ),
      decoration: BoxDecoration(
        color: MarineColors.actionTeal.withAlpha(30),
        border: const Border(
          left: BorderSide(color: MarineColors.actionTeal, width: 3),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(MarineSpacing.radiusMd),
          bottomRight: Radius.circular(MarineSpacing.radiusMd),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SUGGESTED APPROACH',
            style: MarineTypography.label.copyWith(
              color: MarineColors.actionTeal,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: MarineSpacing.xs),
          Text(
            approach,
            style: MarineTypography.bodyMedium.copyWith(
              color: MarineColors.onDark,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

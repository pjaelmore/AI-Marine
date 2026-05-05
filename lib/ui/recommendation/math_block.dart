import 'package:flutter/material.dart';

import '../../core/types/score_result.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// Three-row "show your work" math block at the bottom of the
/// recommendation card body. Mirrors the formula spelled out in TDD
/// §3.5: `final = (base × ∏ modifiers) + Σ contributors`.
///
/// Rendered as:
/// ```
///   Base × modifiers       7.06
///   + Contributors         1.75
///   ─────────────────────────────
///   Final                  8.81
/// ```
///
/// The numbers come straight from [ReasoningBreakdown] — this widget
/// formats and lays them out, it does not recompute. Tabular figures
/// keep the right edge aligned regardless of digit count.
class MathBlock extends StatelessWidget {
  const MathBlock({super.key, required this.reasoning});

  final ReasoningBreakdown reasoning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MarineSpacing.lg,
        vertical: MarineSpacing.md,
      ),
      decoration: BoxDecoration(
        color: MarineColors.deepMarine,
        border: Border.all(color: MarineColors.divider),
        borderRadius: BorderRadius.circular(MarineSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MathRow(
            label: 'Base × modifiers',
            value: reasoning.rawScoreBeforeContributors,
          ),
          const SizedBox(height: MarineSpacing.xs),
          _MathRow(
            label: '+ Contributors',
            value: reasoning.additiveTotal,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: MarineSpacing.sm),
            child: Divider(
              height: 1,
              thickness: 1,
              color: MarineColors.divider,
            ),
          ),
          _MathRow(
            label: 'Final',
            value: reasoning.finalScore,
            emphasized: true,
          ),
        ],
      ),
    );
  }
}

class _MathRow extends StatelessWidget {
  const _MathRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final double value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final labelStyle = MarineTypography.bodySmall.copyWith(
      color: emphasized
          ? MarineColors.actionTeal
          : MarineColors.onDark.withAlpha(160),
      fontWeight: emphasized ? FontWeight.w700 : FontWeight.w400,
      fontSize: emphasized ? 14 : 13,
    );
    final valueStyle = MarineTypography.bodySmall.copyWith(
      color: emphasized ? MarineColors.actionTeal : MarineColors.onDark,
      fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
      fontSize: emphasized ? 16 : 13,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Text(value.toStringAsFixed(2), style: valueStyle),
      ],
    );
  }
}

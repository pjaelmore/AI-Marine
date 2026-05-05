import 'package:flutter/material.dart';

import '../../core/types/score_result.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// One row per [GateResult] at the top of the recommendation card.
///
/// Gates are binary (pass/fail). Pass: green pill with ✓ + the
/// humanized gate name. Fail: amber pill with the failure reason —
/// when a gate fails, `finalScore == 0` and the modifiers / contributors
/// sections are empty, so this row is the *whole* explanation.
///
/// **Why amber, not red, for failure.** Red on a marine surface reads
/// as "danger / no-go" — a navigation cue, not an explanation. Amber
/// reads as "advisory" which is what a failed gate is: "this query
/// won't produce a useful score for the reason given." The user can
/// still pick a different spot or time.
class GateRow extends StatelessWidget {
  const GateRow({super.key, required this.gate});

  final GateResult gate;

  @override
  Widget build(BuildContext context) {
    final passed = gate.passed;
    final fg = passed ? MarineColors.actionTeal : MarineColors.warnAmber;
    final bgAlpha = passed ? 30 : 38;

    return Container(
      margin: const EdgeInsets.only(bottom: MarineSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: MarineSpacing.md,
        vertical: MarineSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: fg.withAlpha(bgAlpha),
        borderRadius: BorderRadius.circular(MarineSpacing.radiusSm),
        border: Border(left: BorderSide(color: fg, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            passed ? Icons.check_circle_outline : Icons.error_outline,
            size: 18,
            color: fg,
          ),
          const SizedBox(width: MarineSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _humanize(gate.name),
                  style: MarineTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: fg,
                  ),
                ),
                if (!passed && gate.failureReason != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    gate.failureReason!,
                    style: MarineTypography.bodySmall.copyWith(
                      color: MarineColors.onDark.withAlpha(200),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Snake-case → sentence-case, matching ModifierBarTile's formatter.
String _humanize(String snake) {
  if (snake.isEmpty) return snake;
  final spaced = snake.replaceAll('_', ' ');
  return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}

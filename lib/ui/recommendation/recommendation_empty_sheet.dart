import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'sheet_chrome.dart';

/// Bottom-sheet rendered before the user has tapped a spot — a hint
/// that the chart is interactive. Visually quiet so it doesn't compete
/// with the chart features above; muted icon + plain instructional
/// text + the same chrome the real card uses, so the user sees "this
/// is where the recommendation will appear".
///
/// The chart shell shows this until the first tap, then swaps to
/// [RecommendationLoadingSheet] → [RecommendationCardSheet].
class RecommendationEmptySheet extends StatelessWidget {
  const RecommendationEmptySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SheetChrome(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          MarineSpacing.xl,
          MarineSpacing.md,
          MarineSpacing.xl,
          MarineSpacing.lg,
        ),
        child: Row(
          children: [
            Icon(
              Icons.touch_app_outlined,
              color: MarineColors.onDark.withAlpha(140),
              size: 24,
            ),
            const SizedBox(width: MarineSpacing.md),
            Expanded(
              child: Text(
                'Tap a spot on the chart to see a recommendation.',
                style: MarineTypography.bodyMedium.copyWith(
                  color: MarineColors.onDark.withAlpha(180),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

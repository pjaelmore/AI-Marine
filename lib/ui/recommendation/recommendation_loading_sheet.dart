import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'sheet_chrome.dart';

/// Bottom-sheet placeholder rendered while the score provider is in
/// flight. Visual language matches [RecommendationCardSheet]'s peek
/// state — same rounded-top surface, grabber, drop shadow — so the
/// transition into the real card after the score lands feels like
/// content arriving in the same container, not the container itself
/// changing.
///
/// The chart shell decides when this is visible (`AsyncValue.loading`
/// from the score provider) and positions it via Stack alignment.
class RecommendationLoadingSheet extends StatelessWidget {
  const RecommendationLoadingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SheetChrome(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MarineSpacing.xl,
          vertical: MarineSpacing.lg,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  MarineColors.actionTeal,
                ),
              ),
            ),
            const SizedBox(width: MarineSpacing.md),
            Expanded(
              child: Text(
                'Calculating recommendation…',
                style: MarineTypography.bodyMedium.copyWith(
                  color: MarineColors.onDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

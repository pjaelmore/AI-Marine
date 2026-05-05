import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'sheet_chrome.dart';

/// Bottom-sheet rendered when the score provider throws (e.g. species
/// data load failure, NDBC fetch error, calibration cache miss). Reuses
/// the [SheetChrome] so the failure surface is recognizably part of the
/// recommendation experience — same shape, same rounded top, just
/// different content.
///
/// The retry callback is the chart shell's hook to re-trigger the
/// score provider. When omitted, the retry button is hidden — useful
/// for previews and tests where there's nothing to retry.
class RecommendationErrorSheet extends StatelessWidget {
  const RecommendationErrorSheet({
    super.key,
    required this.message,
    this.onRetry,
  });

  /// Short human-readable failure description. The chart shell maps
  /// raw exceptions to user-friendly text (e.g. "No internet
  /// connection" rather than "SocketException: Failed host lookup").
  final String message;

  /// Optional retry handler. When wired, a "Try again" button appears
  /// below the message.
  final VoidCallback? onRetry;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: MarineColors.warnAmber,
                  size: 22,
                ),
                const SizedBox(width: MarineSpacing.sm),
                Expanded(
                  child: Text(
                    "Couldn't calculate recommendation",
                    style: MarineTypography.headingSmall.copyWith(
                      color: MarineColors.onDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: MarineSpacing.sm),
            Text(
              message,
              style: MarineTypography.bodyMedium.copyWith(
                color: MarineColors.onDark.withAlpha(180),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: MarineSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Try again'),
                  style: TextButton.styleFrom(
                    foregroundColor: MarineColors.actionTeal,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

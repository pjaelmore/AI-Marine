import 'package:flutter/material.dart';

import '../../core/types/score_result.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// One row in the recommendation card's "What's adding" section.
///
/// Contributors only ever add, so the visualization is simpler than
/// [ModifierBarTile] — no neutral mark, no boost-vs-dampen color
/// distinction. The bar fills `0 → value` along the `[0, rangeMax]`
/// envelope.
///
/// **Zero-value treatment.** A contributor whose value is exactly 0
/// renders a muted "no signal" subtitle instead of an empty bar. The
/// recent-catches contributor hits this constantly until the user
/// logs catches; rendering it as a flat bar suggests the contributor
/// "didn't matter" when the truth is "had nothing to feed on."
class ContributorBarTile extends StatelessWidget {
  const ContributorBarTile({super.key, required this.contributor});

  final ContributorApplication contributor;

  bool get _zero => contributor.value == 0;

  /// Fill width as a fraction of the bar.
  double get _fillFraction {
    if (contributor.rangeMax == 0) return 0;
    return (contributor.value / contributor.rangeMax).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MarineSpacing.md + 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _humanize(contributor.name),
                  style: MarineTypography.bodyMedium,
                ),
              ),
              Text(
                _zero ? '—' : '+${contributor.value.toStringAsFixed(2)}',
                style: MarineTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _zero
                      ? MarineColors.onDark.withAlpha(120)
                      : MarineColors.actionTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: MarineSpacing.xs + 2),
          // Track + fill. Container instead of Stack since contributor
          // bars don't need a neutral marker.
          ClipRRect(
            borderRadius: BorderRadius.circular(MarineSpacing.radiusSm / 2),
            child: Container(
              height: 8,
              color: MarineColors.onDark.withAlpha(20),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _fillFraction,
                child: Container(color: MarineColors.actionTeal),
              ),
            ),
          ),
          const SizedBox(height: MarineSpacing.xs),
          Text(
            contributor.description,
            style: MarineTypography.bodySmall.copyWith(
              color: MarineColors.onDark.withAlpha(_zero ? 110 : 170),
              fontStyle: _zero ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}

String _humanize(String snake) {
  if (snake.isEmpty) return snake;
  final spaced = snake.replaceAll('_', ' ');
  return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}

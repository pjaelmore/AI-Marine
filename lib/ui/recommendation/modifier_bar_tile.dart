import 'package:flutter/material.dart';

import '../../core/types/score_result.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// One row in the recommendation card's "What's boosting" / "What's
/// dampening" section — TDD §10.3.2.
///
/// Visualizes a [ModifierApplication] as a horizontal track:
///
/// ```
///   Water temp · 78°F                      ×2.0
///   ████████████████████████████░░░░━━━━━━━━━━ ← gradient track
///                                  ●          ← value dot
///                              │              ← neutral mark at 1.0
///   Square in optimal 68–82°F band
/// ```
///
/// **Gradient direction.** Left-to-right runs cool-→-warm: the left
/// half (sub-neutral) reads as a dampening hue, the right half
/// (super-neutral) reads as a boost. The neutral hairline at 1.0
/// (mid-track) gives a stable reference so the user can see at a
/// glance whether a modifier is helping or hurting without reading
/// the number.
///
/// **Unverified handling.** Modifiers whose source is "unverified" in
/// the species data still appear in the breakdown — but as a thin
/// gray row with an `UNVERIFIED` badge, no track. Honest about which
/// inputs are pinned to peer-reviewed data and which are best-guess.
/// The chart shell decides which of the two flavors to render based
/// on whether `dataProvenance[modifier.name]` is "unverified" — for
/// the v1 card body we receive a flag from the caller.
class ModifierBarTile extends StatelessWidget {
  const ModifierBarTile({
    super.key,
    required this.modifier,
    this.unverified = false,
  });

  final ModifierApplication modifier;

  /// When true, render the muted "unverified — no peer-reviewed data"
  /// presentation instead of the bar.
  final bool unverified;

  @override
  Widget build(BuildContext context) {
    if (unverified) return _UnverifiedRow(modifier: modifier);
    return _VerifiedBar(modifier: modifier);
  }
}

class _VerifiedBar extends StatelessWidget {
  const _VerifiedBar({required this.modifier});

  final ModifierApplication modifier;

  /// Where on the track to position the value dot, in [0, 1] of the
  /// bar's width. Clamped so a value past the documented envelope
  /// doesn't push the dot off the bar.
  double get _normalizedPosition {
    final span = modifier.rangeMax - modifier.rangeMin;
    if (span == 0) return 0.5;
    final raw = (modifier.value - modifier.rangeMin) / span;
    return raw.clamp(0.0, 1.0);
  }

  /// Where the neutral mark sits — at value 1.0, normalized into the
  /// bar's `[rangeMin, rangeMax]` envelope. For the standard
  /// `[0, 2]` envelope this is exactly 50%.
  double get _neutralPosition {
    final span = modifier.rangeMax - modifier.rangeMin;
    if (span == 0) return 0.5;
    return ((1.0 - modifier.rangeMin) / span).clamp(0.0, 1.0);
  }

  bool get _boosting => modifier.value > 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MarineSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _humanize(modifier.name),
                  style: MarineTypography.bodyMedium,
                ),
              ),
              Text(
                '×${modifier.value.toStringAsFixed(modifier.value < 10 ? 2 : 1)}',
                style: MarineTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _boosting
                      ? MarineColors.actionTeal
                      : MarineColors.warnAmber,
                ),
              ),
            ],
          ),
          const SizedBox(height: MarineSpacing.xs + 2),
          // The bar itself. Stack: gradient track behind, neutral
          // hairline middle, value dot on top.
          SizedBox(
            height: 14,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MarineSpacing.radiusSm),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0x8CDC4646),
                            Color(0x24FFFFFF),
                            Color(0xA61FA37F),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * _neutralPosition - 0.5,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 1,
                        color: MarineColors.onDark.withAlpha(140),
                      ),
                    ),
                    Positioned(
                      left: (width * _normalizedPosition) - 8,
                      top: -1,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: MarineColors.onDark,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: MarineColors.surfaceElevated,
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x80000000),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: MarineSpacing.xs),
          Text(
            modifier.description,
            style: MarineTypography.bodySmall.copyWith(
              color: MarineColors.onDark.withAlpha(170),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnverifiedRow extends StatelessWidget {
  const _UnverifiedRow({required this.modifier});

  final ModifierApplication modifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: MarineSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: MarineSpacing.md,
        vertical: MarineSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: MarineColors.onDark.withAlpha(10),
        borderRadius: BorderRadius.circular(MarineSpacing.radiusSm),
        border: Border(
          left: BorderSide(
            color: MarineColors.onDark.withAlpha(60),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '— ',
            style: MarineTypography.bodyMedium.copyWith(
              color: MarineColors.onDark.withAlpha(100),
            ),
          ),
          Expanded(
            child: Text(
              _humanize(modifier.name),
              style: MarineTypography.bodyMedium.copyWith(
                color: MarineColors.onDark.withAlpha(170),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: MarineSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: MarineColors.warnAmber.withAlpha(40),
              borderRadius: BorderRadius.circular(MarineSpacing.xs),
            ),
            child: Text(
              'UNVERIFIED',
              style: MarineTypography.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: MarineColors.warnAmber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Turns `water_temperature` into "Water temperature" for display —
/// sentence case to match the card header's species formatter
/// ("common-snook" → "Common snook"). Only the first word is
/// capitalized so labels read like English rather than headlines.
String _humanize(String snake) {
  if (snake.isEmpty) return snake;
  final spaced = snake.replaceAll('_', ' ');
  return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}

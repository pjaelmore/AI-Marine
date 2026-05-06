import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/spacing.dart';

/// Shared visual chrome for the recommendation card and its loading /
/// error / empty siblings: rounded-top surface, top shadow, divider-
/// colored grabber pill at the top center.
///
/// Extracted so a state transition (loading → card, or error → card on
/// retry) feels like the *contents* swap inside one container rather
/// than the container itself coming and going.
class SheetChrome extends StatelessWidget {
  const SheetChrome({super.key, required this.child});

  /// Inner content. Caller controls padding so the loading row, the
  /// error layout, and the rich card body each get the spacing that
  /// fits their density.
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: MarineSpacing.md),
          const SheetGrabber(),
          const SizedBox(height: MarineSpacing.md),
          child,
        ],
      ),
    );
  }
}

/// The horizontal pill at the top of the sheet that signals
/// draggability. 44×4 dp — wide enough to read as an affordance, thin
/// enough not to compete with the score block beneath it.
class SheetGrabber extends StatelessWidget {
  const SheetGrabber({super.key});

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

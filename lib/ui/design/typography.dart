import 'package:flutter/material.dart';

/// Typography tokens for the AI Marine Engine.
///
/// Per TDD §10.1: system font stack (SF on iOS, Roboto on Android), body 16pt
/// minimum, numeric readouts 22pt minimum. Numeric styles use tabular figures
/// so depth, temperature, and score readouts don't reflow as values change.
abstract final class MarineTypography {
  /// Minimum body text size mandated by the spec.
  static const bodyMinSize = 16.0;

  /// Minimum size for numeric readouts (depth, water temp, score).
  static const numericMinSize = 22.0;

  static const _tabularFigures = <FontFeature>[FontFeature.tabularFigures()];

  // ── Body ───────────────────────────────────────────────────────────────
  static const bodyLarge = TextStyle(
    fontSize: bodyMinSize,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );
  static const bodyMedium = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w400,
  );

  // ── Numeric readouts ───────────────────────────────────────────────────
  /// Helm/card readouts: water temp, depth, wind speed, etc.
  static const numericReadout = TextStyle(
    fontSize: numericMinSize,
    fontWeight: FontWeight.w600,
    fontFeatures: _tabularFigures,
  );

  /// Score numeral on recommendation pins. Smaller than the card header
  /// numeral because pins live on the chart and must not crowd features.
  static const pinNumeral = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFeatures: _tabularFigures,
  );

  /// Final-score numeral in the recommendation card header.
  static const cardScoreNumeral = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    fontFeatures: _tabularFigures,
    height: 1.0,
  );

  // ── Headings ───────────────────────────────────────────────────────────
  static const headingLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const headingSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // ── Labels / captions ──────────────────────────────────────────────────
  static const label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );
}

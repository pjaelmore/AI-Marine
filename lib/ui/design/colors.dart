import 'package:flutter/material.dart';

/// Color tokens for the AI Marine Engine.
///
/// Sourced from TDD §10.1 (palette) and §10.2.2 (heatmap stops). The palette
/// is deliberately small — three brand hues plus white — chosen to remain
/// legible in direct sunlight on a boat helm.
abstract final class MarineColors {
  // ── Brand palette — TDD §10.1 ──────────────────────────────────────────
  /// Deep marine blue. Primary surface color (chart background, scaffold).
  static const deepMarine = Color(0xFF0F2A47);

  /// Teal-green. Action surfaces, recommendation pins, "live" indicator.
  static const actionTeal = Color(0xFF0F6E56);

  /// Amber. Warnings and stale-data indicators.
  static const warnAmber = Color(0xFFE89F3C);

  /// High-contrast white for text on dark surfaces.
  static const onDark = Color(0xFFFFFFFF);

  // ── Surface elevation — derived from deepMarine ────────────────────────
  /// Slightly lighter surface for cards / sheets sitting above the chart.
  static const surfaceElevated = Color(0xFF173453);

  /// Hairline divider on dark surfaces.
  static const divider = Color(0x33FFFFFF);

  // ── Mode indicator dots — TDD §10.2.4 ──────────────────────────────────
  /// Live data — reuses the action teal.
  static const modeLive = actionTeal;

  /// Cached data — amber, matching the staleness palette.
  static const modeCached = warnAmber;

  /// NMEA 2000 connected — marine blue, distinct from the deep-marine surface.
  static const modeNmea = Color(0xFF1E6FB8);

  // ── Heatmap stops — TDD §10.2.2 ────────────────────────────────────────
  // Cells with score < 4.0 produce no fill (transparent). Opacity peaks at
  // 0.45 so chart features beneath remain legible.
  static const heatmapAmberLow = Color(0x33E89F3C); // α 0.20 — 4.0–5.5
  static const heatmapAmberMid = Color(0x59E89F3C); // α 0.35 — 5.5–7.0
  static const heatmapTransition = Color(0x4C7B8A4F); // α ~0.30 — 7.0–7.5
  static const heatmapGreenMid = Color(0x590F6E56); // α 0.35 — 7.5–9.0
  static const heatmapGreenHigh = Color(0x730F6E56); // α 0.45 — 9.0–10.0
}

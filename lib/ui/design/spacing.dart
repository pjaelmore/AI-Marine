/// Spacing and touch-target tokens for the AI Marine Engine.
///
/// The base unit is 4dp; the scale doubles roughly every step. Touch targets
/// per TDD §10.1: 48dp on phone, 56dp on tablet, 64dp on helm-mode tablet.
/// Larger targets accommodate wet hands and motion at sea.
abstract final class MarineSpacing {
  // ── 4dp spacing scale ──────────────────────────────────────────────────
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const xxxl = 48.0;

  // ── Touch targets — TDD §10.1 ──────────────────────────────────────────
  /// Minimum tap target on phones.
  static const touchPhone = 48.0;

  /// Minimum tap target on tablets.
  static const touchTablet = 56.0;

  /// Minimum tap target on helm-mounted tablets.
  static const touchHelm = 64.0;

  // ── Surface radii ──────────────────────────────────────────────────────
  static const radiusSm = 8.0;
  static const radiusMd = 12.0;
  static const radiusLg = 16.0;

  // ── Borders ────────────────────────────────────────────────────────────
  static const hairline = 1.0;
}

// Spacing scale, radii, layout constants and breakpoints.
//
// Numeric values stay numeric (easy to do math on); fluid values are CSS
// strings. Both are emitted as custom properties in global_styles.dart.

abstract final class AppSpacing {
  // ----- Spacing scale (rem) -----
  static const double xs  = 0.25;
  static const double sm  = 0.5;
  static const double md  = 1.0;
  static const double lg  = 1.5;
  static const double xl  = 2.5;
  static const double xxl = 4.0;

  // ----- Fluid layout -----
  static const String gutter   = 'clamp(1.25rem, 4vw, 3.5rem)';
  static const String sectionY = 'clamp(6rem, 14vh, 11rem)';
  static const double container = 1440; // px — page max-width

  // ----- Radii (px) -----
  static const double radiusSm   = 10;
  static const double radiusMd   = 18;
  static const double radiusLg   = 28;
  static const double radiusXl   = 44;
  static const double radiusFull = 999;

  // ----- Component sizes -----
  static const double navbarHeight = 76; // px — used for scroll offsets

  // ----- Breakpoints (px) — mobile-first -----
  static const int bpSm = 560;
  static const int bpMd = 768;
  static const int bpLg = 1024;
  static const int bpXl = 1280;
}

// Typography tokens — fonts, fluid sizes, weights, tracking.
//
// Four families, each with one job:
//   - Inter Tight  → display headings (tight, confident, editorial)
//   - Instrument Serif (italic) → accent words inside headings (`_word_`)
//   - Inter        → body copy
//   - JetBrains Mono → small labels, indices, metadata
//
// Fonts load via the <link> in main.server.dart (`googleFontsUrl`).
// Sizes are emitted as CSS custom properties in global_styles.dart so raw
// CSS strings can reference them (`font-size: var(--fs-h2)`).

import 'package:jaspr/dom.dart';

abstract final class AppTypography {
  // ----- Families ----------------------------------------------------------
  static const FontFamily fontDisplay = FontFamily('Inter Tight');
  static const FontFamily fontBody    = FontFamily('Inter');
  static const FontFamily fontSerif   = FontFamily('Instrument Serif');
  static const FontFamily fontMono    = FontFamily('JetBrains Mono');

  static const String displayStack =
      "'Inter Tight', 'Inter', system-ui, -apple-system, 'Segoe UI', sans-serif";
  static const String bodyStack =
      "'Inter', system-ui, -apple-system, 'Segoe UI', sans-serif";
  static const String serifStack =
      "'Instrument Serif', 'Iowan Old Style', 'Times New Roman', serif";
  static const String monoStack =
      "'JetBrains Mono', ui-monospace, SFMono-Regular, Menlo, monospace";

  static const String googleFontsUrl =
      'https://fonts.googleapis.com/css2'
      '?family=Inter:wght@400;500;600'
      '&family=Inter+Tight:wght@400;500;600;700'
      '&family=Instrument+Serif:ital@0;1'
      '&family=JetBrains+Mono:wght@400;500'
      '&display=swap';

  // ----- Fluid sizes (clamp) ----------------------------------------------
  static const String displayClamp = 'clamp(3.4rem, 14.6vw, 15.5rem)';
  static const String h2Clamp      = 'clamp(2.6rem, 7.2vw, 7rem)';
  static const String h3Clamp      = 'clamp(1.7rem, 3.2vw, 3rem)';
  static const String leadClamp    = 'clamp(1.55rem, 3.6vw, 3.4rem)';
  static const String bodyLgClamp  = 'clamp(1.05rem, 1.25vw, 1.2rem)';

  static const String bodySize  = '1rem';
  static const String smallSize = '0.875rem';
  static const String labelSize = '0.72rem';

  // ----- Weights -----------------------------------------------------------
  static const FontWeight regular  = FontWeight.w400;
  static const FontWeight medium   = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;

  // ----- Rhythm ------------------------------------------------------------
  static const String lineHeightDisplay = '0.92';
  static const String lineHeightTight   = '1.05';
  static const String lineHeightBody    = '1.6';
  static const String trackingDisplay   = '-0.045em';
  static const String trackingHeading   = '-0.035em';
  static const String trackingLabel     = '0.14em';
}

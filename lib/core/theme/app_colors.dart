// The project's color tokens.
//
// Two layers:
//   1. Raw hex palette (`*Hex`) — read ONLY by `global_styles.dart`, which
//      emits them once as CSS custom properties on `:root` (dark "ink") and
//      on `.theme-paper` (light "paper" sections).
//   2. Typed `Color('var(--x)')` refs — what sections/widgets use.
//
// Because every component reads `var(--x)`, a section can flip to the light
// paper palette just by adding the `theme-paper` class: the custom
// properties cascade and every child recolors with zero extra CSS.

import 'package:jaspr/dom.dart';

abstract final class AppColors {
  // ----- Raw palette: ink (default, dark) --------------------------------
  static const String inkBgHex      = '#09090B';
  static const String inkRaisedHex  = '#111114';
  static const String inkSurfaceHex = '#16161A';
  static const String inkTextHex    = '#EDEDF0';
  static const String inkDimHex     = '#9C9CA8';
  static const String inkFaintHex   = '#5C5C68';

  // ----- Raw palette: paper (light sections) -----------------------------
  static const String paperBgHex      = '#EEEDE8';
  static const String paperRaisedHex  = '#E7E6E0';
  static const String paperSurfaceHex = '#E1E0D9';
  static const String paperTextHex    = '#0E0E11';
  static const String paperDimHex     = '#55555E';
  static const String paperFaintHex   = '#8D8D95';

  // ----- Brand accents ----------------------------------------------------
  static const String violetHex  = '#6C63FF';
  static const String cyanHex    = '#00D9FF';
  static const String amberHex   = '#FFB547';
  static const String emeraldHex = '#3DDC97';
  static const String roseHex    = '#FF5C8A';
  static const String goldHex    = '#F2C46D';
  static const String orangeHex  = '#FF6B2C';
  static const String blueHex    = '#4D86FF';

  /// Accent tones selectable from content data (`tone: 'amber'`).
  static const Map<String, String> tones = {
    'violet': violetHex,
    'cyan': cyanHex,
    'amber': amberHex,
    'emerald': emeraldHex,
    'rose': roseHex,
    'gold': goldHex,
    'orange': orangeHex,
    'blue': blueHex,
  };

  /// Brand gradient (logo, progress bar, selection accents).
  static const String brandGradient =
      'linear-gradient(120deg, $violetHex, $cyanHex)';

  // ----- Typed refs (use these in components) ----------------------------
  static const Color bg            = Color('var(--bg)');
  static const Color bgRaised      = Color('var(--bg-raised)');
  static const Color surface       = Color('var(--surface)');
  static const Color textPrimary   = Color('var(--text)');
  static const Color textSecondary = Color('var(--text-dim)');
  static const Color textMuted     = Color('var(--text-faint)');
  static const Color line          = Color('var(--line)');
  static const Color lineStrong    = Color('var(--line-strong)');
  static const Color primary       = Color('var(--primary)');
  static const Color secondary     = Color('var(--secondary)');
  static const Color tone          = Color('var(--tone)');
}

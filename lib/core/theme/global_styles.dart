// Global styles — design tokens as CSS custom properties, reset, base
// typography, layout primitives (.container), the film-grain overlay,
// Lenis smooth-scroll support and accessibility defaults.
//
// Picked up by the Jaspr builder via the `@css` annotation; imported once
// from main.server.dart.

import 'package:jaspr/dom.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// `(min-width: Npx)` media query helper shared by all style files.
MediaQuery minWidth(int px) => MediaQuery.raw('(min-width: ${px}px)');

/// `(max-width: N-1px)` media query helper.
MediaQuery maxWidth(int px) => MediaQuery.raw('(max-width: ${px - 1}px)');

@css
List<StyleRule> get globalStyles => [
  // -----------------------------------------------------------------
  // 1. Tokens — INK (default dark palette) on :root.
  // -----------------------------------------------------------------
  css(':root').styles(raw: {
    // Surfaces + text
    '--bg': AppColors.inkBgHex,
    '--bg-raised': AppColors.inkRaisedHex,
    '--surface': AppColors.inkSurfaceHex,
    '--text': AppColors.inkTextHex,
    '--text-dim': AppColors.inkDimHex,
    '--text-faint': AppColors.inkFaintHex,
    '--line': 'rgba(255, 255, 255, 0.08)',
    '--line-strong': 'rgba(255, 255, 255, 0.16)',
    '--glass': 'rgba(18, 18, 22, 0.62)',
    // Brand
    '--primary': AppColors.violetHex,
    '--secondary': AppColors.cyanHex,
    '--tone': AppColors.violetHex,
    '--brand-gradient': AppColors.brandGradient,
    '--success': AppColors.emeraldHex,
    // Type
    '--font-display': AppTypography.displayStack,
    '--font-body': AppTypography.bodyStack,
    '--font-serif': AppTypography.serifStack,
    '--font-mono': AppTypography.monoStack,
    '--fs-display': AppTypography.displayClamp,
    '--fs-h2': AppTypography.h2Clamp,
    '--fs-h3': AppTypography.h3Clamp,
    '--fs-lead': AppTypography.leadClamp,
    '--fs-body-lg': AppTypography.bodyLgClamp,
    '--fs-small': AppTypography.smallSize,
    '--fs-label': AppTypography.labelSize,
    // Layout
    '--gutter': AppSpacing.gutter,
    '--section-y': AppSpacing.sectionY,
    '--container': '${AppSpacing.container.toInt()}px',
    '--nav-h': '${AppSpacing.navbarHeight.toInt()}px',
    '--radius-sm': '${AppSpacing.radiusSm.toInt()}px',
    '--radius-md': '${AppSpacing.radiusMd.toInt()}px',
    '--radius-lg': '${AppSpacing.radiusLg.toInt()}px',
    '--radius-xl': '${AppSpacing.radiusXl.toInt()}px',
    // Motion — one easing family for the whole site.
    '--ease-out': 'cubic-bezier(0.22, 1, 0.36, 1)',
    '--ease-in-out': 'cubic-bezier(0.76, 0, 0.24, 1)',
    '--ease-expo': 'cubic-bezier(0.16, 1, 0.3, 1)',
    'color-scheme': 'dark',
  }),

  // -----------------------------------------------------------------
  // 1b. PAPER palette — any element with .theme-paper re-skins itself
  //     and all of its children through the cascade.
  // -----------------------------------------------------------------
  css('.theme-paper').styles(raw: {
    '--bg': AppColors.paperBgHex,
    '--bg-raised': AppColors.paperRaisedHex,
    '--surface': AppColors.paperSurfaceHex,
    '--text': AppColors.paperTextHex,
    '--text-dim': AppColors.paperDimHex,
    '--text-faint': AppColors.paperFaintHex,
    '--line': 'rgba(14, 14, 17, 0.12)',
    '--line-strong': 'rgba(14, 14, 17, 0.26)',
    '--primary': '#5148E8',
    'color-scheme': 'light',
    'background-color': 'var(--bg)',
    'color': 'var(--text)',
  }),

  // Accent tones selectable from data: <el data-tone="amber">.
  for (final entry in AppColors.tones.entries)
    css('[data-tone="${entry.key}"]').styles(raw: {'--tone': entry.value}),

  // -----------------------------------------------------------------
  // 2. Reset.
  // -----------------------------------------------------------------
  css('*, *::before, *::after').styles(
    padding: Padding.zero,
    margin: Margin.zero,
    boxSizing: BoxSizing.borderBox,
  ),

  css('html').styles(raw: {
    'width': '100%',
    'scroll-padding-top': 'var(--nav-h)',
    '-webkit-text-size-adjust': '100%',
    'background-color': 'var(--bg)',
  }),

  css('body').styles(raw: {
    'min-height': '100vh',
    'background-color': 'var(--bg)',
    'color': 'var(--text)',
    'font-family': 'var(--font-body)',
    'font-size': AppTypography.bodySize,
    'line-height': AppTypography.lineHeightBody,
    'overflow-x': 'clip',
    '-webkit-font-smoothing': 'antialiased',
    '-moz-osx-font-smoothing': 'grayscale',
    'text-rendering': 'optimizeLegibility',
  }),

  css('img, svg, video').styles(raw: {'display': 'block', 'max-width': '100%'}),
  css('ul, ol').styles(raw: {'list-style': 'none'}),
  css('button').styles(raw: {
    'font': 'inherit',
    'color': 'inherit',
    'background': 'none',
    'border': '0',
    'cursor': 'pointer',
  }),
  css('a').styles(raw: {'color': 'inherit', 'text-decoration': 'none'}),

  // -----------------------------------------------------------------
  // 3. Base typography.
  // -----------------------------------------------------------------
  css('h1, h2, h3, h4').styles(raw: {
    'font-family': 'var(--font-display)',
    'font-weight': '500',
    'letter-spacing': AppTypography.trackingHeading,
    'line-height': AppTypography.lineHeightTight,
    'color': 'var(--text)',
  }),
  css('p').styles(raw: {'color': 'var(--text-dim)'}),

  // Serif-italic accent used inside headings (`_word_` in data).
  css('.serif').styles(raw: {
    'font-family': 'var(--font-serif)',
    'font-style': 'italic',
    'font-weight': '400',
    'letter-spacing': '-0.02em',
  }),

  // Mono metadata label: "01 — ABOUT".
  css('.label').styles(raw: {
    'font-family': 'var(--font-mono)',
    'font-size': 'var(--fs-label)',
    'font-weight': '400',
    'letter-spacing': AppTypography.trackingLabel,
    'text-transform': 'uppercase',
    'color': 'var(--text-dim)',
  }),
  css('.mono').styles(raw: {'font-family': 'var(--font-mono)'}),

  css('::selection').styles(raw: {
    'background': 'var(--primary)',
    'color': '#FFFFFF',
  }),

  // -----------------------------------------------------------------
  // 4. Layout primitives.
  // -----------------------------------------------------------------
  css('.container').styles(raw: {
    'width': '100%',
    'max-width': 'var(--container)',
    'margin-inline': 'auto',
    'padding-inline': 'var(--gutter)',
  }),
  css('.section').styles(raw: {
    'position': 'relative',
    'padding-block': 'var(--section-y)',
  }),
  css('.sr-only').styles(raw: {
    'position': 'absolute',
    'width': '1px',
    'height': '1px',
    'overflow': 'hidden',
    'clip': 'rect(0 0 0 0)',
    'white-space': 'nowrap',
  }),

  // -----------------------------------------------------------------
  // 5. Film grain — fixed SVG-noise overlay that jitters in steps, the
  //    way real film grain does. pointer-events: none so it never blocks.
  // -----------------------------------------------------------------
  css('.grain').styles(raw: {
    'position': 'fixed',
    'inset': '-50%',
    'z-index': '9000',
    'pointer-events': 'none',
    'opacity': '0.055',
    'background-image':
        'url("data:image/svg+xml;utf8,'
        '<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22220%22 height=%22220%22>'
        '<filter id=%22n%22>'
        '<feTurbulence type=%22fractalNoise%22 baseFrequency=%220.8%22 numOctaves=%223%22 stitchTiles=%22stitch%22/>'
        '<feColorMatrix values=%221 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0.7 0%22/>'
        '</filter>'
        '<rect width=%22100%25%22 height=%22100%25%22 filter=%22url(%23n)%22/>'
        '</svg>")',
    'background-size': '220px 220px',
    'animation': 'grain 7s steps(8) infinite',
  }),

  // -----------------------------------------------------------------
  // 6. Lenis smooth-scroll support (mirrors lenis.css).
  // -----------------------------------------------------------------
  css('html.lenis, html.lenis body').styles(raw: {'height': 'auto'}),
  css('.lenis.lenis-smooth').styles(raw: {'scroll-behavior': 'auto !important'}),
  css('.lenis.lenis-stopped').styles(raw: {'overflow': 'clip'}),
  css('.lenis.lenis-smooth [data-lenis-prevent]').styles(raw: {
    'overscroll-behavior': 'contain',
  }),
  // While the preloader runs, freeze the page.
  css('html.is-loading, html.is-loading body').styles(raw: {'overflow': 'hidden'}),

  // Scrollbar — thin and quiet.
  css('html').styles(raw: {
    'scrollbar-width': 'thin',
    'scrollbar-color': 'var(--line-strong) transparent',
  }),

  // -----------------------------------------------------------------
  // 7. Focus styles — keyboard users get a clear ring, mouse users don't.
  // -----------------------------------------------------------------
  css(':focus').styles(raw: {'outline': 'none'}),
  css(':focus-visible').styles(raw: {
    'outline': '2px solid var(--primary)',
    'outline-offset': '4px',
    'border-radius': '6px',
  }),

  // -----------------------------------------------------------------
  // 8. Reduced-motion safety net.
  // -----------------------------------------------------------------
  css.media(MediaQuery.raw('(prefers-reduced-motion: reduce)'), [
    css('*, *::before, *::after').styles(raw: {
      'animation-duration': '0.01ms !important',
      'animation-iteration-count': '1 !important',
      'transition-duration': '0.01ms !important',
      'scroll-behavior': 'auto !important',
    }),
    css('.grain').styles(raw: {'display': 'none'}),
  ]),
];

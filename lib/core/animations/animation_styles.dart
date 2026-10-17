// Animation stylesheet — the shared motion vocabulary of the site.
//
//   1. @keyframes (grain, orbs, marquee, pulses).
//   2. The reveal system:
//        [data-reveal]          → fade/slide in when scrolled into view
//        [data-split] .line     → masked line-by-line text reveal
//        [data-load]            → same, but played when the preloader ends
//      JS (animation_scripts.dart) adds `.is-in` to play them.
//   3. Utilities: .magnetic, .hover-line.
//
// Hidden "from" states only apply under `html.js` (set by an inline head
// script), so the page is fully readable with JavaScript disabled. If the
// motion script fails, the head script adds `.reveal-all` as a failsafe.

import 'package:jaspr/dom.dart';

@css
List<StyleRule> get animationStyles => [
  // ===================================================================
  // 1. @keyframes
  // ===================================================================
  css.keyframes('grain', const {
    '0%, 100%': Styles(raw: {'transform': 'translate(0, 0)'}),
    '10%': Styles(raw: {'transform': 'translate(-5%, -10%)'}),
    '30%': Styles(raw: {'transform': 'translate(3%, -15%)'}),
    '50%': Styles(raw: {'transform': 'translate(12%, 9%)'}),
    '70%': Styles(raw: {'transform': 'translate(9%, 4%)'}),
    '90%': Styles(raw: {'transform': 'translate(-1%, 7%)'}),
  }),
  css.keyframes('orb-drift', const {
    '0%, 100%': Styles(raw: {'transform': 'translate3d(0, 0, 0) scale(1)'}),
    '33%': Styles(raw: {'transform': 'translate3d(6%, -8%, 0) scale(1.08)'}),
    '66%': Styles(raw: {'transform': 'translate3d(-5%, 5%, 0) scale(0.95)'}),
  }),
  css.keyframes('marquee', const {
    '0%': Styles(raw: {'transform': 'translate3d(0, 0, 0)'}),
    '100%': Styles(raw: {'transform': 'translate3d(-50%, 0, 0)'}),
  }),
  css.keyframes('pulse-dot', const {
    '0%': Styles(raw: {'box-shadow': '0 0 0 0 color-mix(in srgb, var(--success) 60%, transparent)'}),
    '70%, 100%': Styles(raw: {'box-shadow': '0 0 0 9px transparent'}),
  }),
  css.keyframes('scroll-line', const {
    '0%': Styles(raw: {'transform': 'scaleY(0)', 'transform-origin': 'top'}),
    '45%': Styles(raw: {'transform': 'scaleY(1)', 'transform-origin': 'top'}),
    '55%': Styles(raw: {'transform': 'scaleY(1)', 'transform-origin': 'bottom'}),
    '100%': Styles(raw: {'transform': 'scaleY(0)', 'transform-origin': 'bottom'}),
  }),
  css.keyframes('rise', const {
    '0%': Styles(raw: {'transform': 'translate3d(0, 110%, 0)'}),
    '100%': Styles(raw: {'transform': 'translate3d(0, 0, 0)'}),
  }),
  css.keyframes('spin', const {
    'to': Styles(raw: {'transform': 'rotate(360deg)'}),
  }),
  css.keyframes('preloader-failsafe', const {
    'to': Styles(raw: {'transform': 'translate3d(0, -100%, 0)', 'visibility': 'hidden'}),
  }),

  // ===================================================================
  // 2a. Reveal — generic blocks.
  // ===================================================================
  css('.js [data-reveal]').styles(raw: {
    'opacity': '0',
    'transform': 'translate3d(0, 44px, 0)',
    'transition':
        'opacity 1.1s var(--ease-out), '
        'transform 1.3s var(--ease-expo), '
        'clip-path 1.4s var(--ease-in-out)',
    'transition-delay': 'var(--d, 0ms)',
  }),
  css('.js [data-reveal="fade"]').styles(raw: {'transform': 'none'}),
  css('.js [data-reveal="scale"]').styles(raw: {
    'transform': 'scale(0.94) translate3d(0, 30px, 0)',
  }),
  css('.js [data-reveal="clip"]').styles(raw: {
    'opacity': '1',
    'transform': 'none',
    'clip-path': 'inset(100% 0 0 0)',
  }),
  css('.js [data-reveal="line"]').styles(raw: {
    'opacity': '1',
    'transform': 'scaleX(0)',
    'transform-origin': 'left center',
  }),
  css('.js [data-reveal].is-in').styles(raw: {
    'opacity': '1',
    'transform': 'none',
    'clip-path': 'inset(0 0 0 0)',
  }),

  // ===================================================================
  // 2b. Reveal — masked lines. Markup (see SplitLines widget):
  //     <h2 data-split><span class="line"><span class="line__inner">…
  // ===================================================================
  css('.line').styles(raw: {
    'display': 'block',
    'overflow': 'hidden',
    // Room for descenders + italic overhang, cancelled by negative margin
    // so the mask doesn't change layout.
    'padding': '0 0.1em 0.1em 0',
    'margin': '0 -0.1em -0.1em 0',
  }),
  css('.line__inner').styles(raw: {'display': 'block'}),
  css('.js [data-split] .line__inner').styles(raw: {
    'transform': 'translate3d(0, 112%, 0) rotate(2.5deg)',
    'transform-origin': 'left top',
    'transition': 'transform 1.35s var(--ease-expo)',
    'transition-delay': 'calc(var(--d, 0ms) + var(--i, 0) * 95ms)',
  }),
  css('.js [data-split].is-in .line__inner').styles(raw: {'transform': 'none'}),

  // ===================================================================
  // 2c. Failsafe — everything visible.
  // ===================================================================
  css('.reveal-all [data-reveal], .reveal-all [data-split] .line__inner').styles(raw: {
    'opacity': '1 !important',
    'transform': 'none !important',
    'clip-path': 'none !important',
  }),

  // ===================================================================
  // 3. Utilities
  // ===================================================================
  // Magnetic elements: JS writes an inline transform; this eases it back.
  css('.magnetic').styles(raw: {
    'transition': 'transform 0.6s var(--ease-out)',
    'will-change': 'transform',
  }),

  // Animated underline for text links.
  css('.hover-line').styles(raw: {
    'position': 'relative',
    'display': 'inline-block',
  }),
  css('.hover-line::after').styles(raw: {
    'content': '""',
    'position': 'absolute',
    'left': '0',
    'right': '0',
    'bottom': '-0.15em',
    'height': '1px',
    'background': 'currentColor',
    'transform': 'scaleX(0)',
    'transform-origin': 'right center',
    'transition': 'transform 0.6s var(--ease-out)',
  }),
  css('.hover-line:hover::after, .hover-line:focus-visible::after').styles(raw: {
    'transform': 'scaleX(1)',
    'transform-origin': 'left center',
  }),
];

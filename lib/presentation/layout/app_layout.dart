// The single page shell.
//
//   <Preloader />               ← intro curtain (JS-only)
//   <progress bar />            ← thin brand-gradient line, scaleX = scroll
//   <Navbar />  <MobileMenu />
//   <main> …sections… </main>
//   <Footer />
//   <cursor ring + dot />       ← fine pointers only, driven by JS
//   <grain />                   ← fixed film-grain overlay
//
// Sections are passed in by app.dart so this widget stays decoupled.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'footer.dart';
import 'mobile_menu.dart';
import 'navbar.dart';
import 'preloader.dart';

class AppLayout extends StatelessComponent {
  const AppLayout({required this.sections, super.key});

  /// The top-level scroll sections in display order.
  final List<Component> sections;

  @override
  Component build(BuildContext context) {
    return div(classes: 'app', [
      const Preloader(),
      div(classes: 'progress', attributes: const {'aria-hidden': 'true'}, [
        span(attributes: const {'data-progress': ''}, []),
      ]),
      const Navbar(),
      const MobileMenu(),
      main_(sections, classes: 'app__main'),
      const Footer(),
      // Ring before dot so `.is-label ~ .cursor--dot` can hide the dot.
      div(
        classes: 'cursor cursor--ring',
        attributes: const {'data-cursor-ring': '', 'aria-hidden': 'true'},
        [
          div(classes: 'cursor__shape', [
            span(classes: 'cursor__label', attributes: const {'data-cursor-label': ''}, []),
          ]),
        ],
      ),
      div(
        classes: 'cursor cursor--dot',
        attributes: const {'data-cursor-dot': '', 'aria-hidden': 'true'},
        [div(classes: 'cursor__shape', [])],
      ),
      div(classes: 'grain', attributes: const {'aria-hidden': 'true'}, []),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.app').styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'flex-direction': 'column',
      'min-height': '100vh',
    }),
    css('.app__main').styles(raw: {'flex': '1 1 auto'}),

    // ----- Scroll progress -----
    css('.progress').styles(raw: {
      'position': 'fixed',
      'top': '0',
      'left': '0',
      'right': '0',
      'z-index': '1001',
      'height': '2px',
      'pointer-events': 'none',
    }),
    css('.progress span').styles(raw: {
      'display': 'block',
      'height': '100%',
      'background': 'var(--brand-gradient)',
      'transform': 'scaleX(0)',
      'transform-origin': 'left',
    }),

    // ----- Custom cursor -----
    css('.cursor').styles(raw: {'display': 'none'}),
    css('.has-cursor .cursor').styles(raw: {
      'position': 'fixed',
      'top': '0',
      'left': '0',
      'z-index': '9800',
      'display': 'block',
      'pointer-events': 'none',
      'opacity': '0',
      'transition': 'opacity 0.3s var(--ease-out)',
      'will-change': 'transform',
    }),
    css('.has-cursor.cursor-on .cursor').styles(raw: {'opacity': '1'}),
    css('.cursor--dot, .cursor--ring').styles(raw: {'mix-blend-mode': 'difference'}),
    css('.cursor--dot .cursor__shape').styles(raw: {
      'width': '6px',
      'height': '6px',
      'margin': '-3px 0 0 -3px',
      'border-radius': '50%',
      'background': '#FFFFFF',
    }),
    css('.cursor--ring .cursor__shape').styles(raw: {
      'display': 'grid',
      'place-items': 'center',
      'width': '40px',
      'height': '40px',
      'margin': '-20px 0 0 -20px',
      'border': '1px solid rgba(255, 255, 255, 0.55)',
      'border-radius': '50%',
      'transition':
          'width 0.5s var(--ease-expo), height 0.5s var(--ease-expo), '
          'margin 0.5s var(--ease-expo), background 0.4s var(--ease-out), '
          'border-color 0.4s var(--ease-out), transform 0.3s var(--ease-out)',
    }),
    css('.cursor--ring.is-link .cursor__shape').styles(raw: {
      'width': '68px',
      'height': '68px',
      'margin': '-34px 0 0 -34px',
      'border-color': '#FFFFFF',
    }),
    css('.cursor--ring.is-label').styles(raw: {'mix-blend-mode': 'normal'}),
    css('.cursor--ring.is-label .cursor__shape').styles(raw: {
      'width': '96px',
      'height': '96px',
      'margin': '-48px 0 0 -48px',
      'background': '#EDEDF0',
      'border-color': 'transparent',
    }),
    css('.cursor--ring.is-down .cursor__shape').styles(raw: {'transform': 'scale(0.85)'}),
    css('.cursor__label').styles(raw: {
      'font-family': 'var(--font-mono)',
      'font-size': '0.7rem',
      'letter-spacing': '0.1em',
      'text-transform': 'uppercase',
      'white-space': 'nowrap',
      'color': '#09090B',
      'opacity': '0',
      'transform': 'scale(0.6)',
      'transition': 'opacity 0.3s var(--ease-out), transform 0.5s var(--ease-expo)',
    }),
    css('.cursor--ring.is-label .cursor__label').styles(raw: {
      'opacity': '1',
      'transform': 'none',
    }),
    css('.cursor--ring.is-label ~ .cursor--dot').styles(raw: {'opacity': '0 !important'}),
    // Native cursor hidden only while the custom one is active.
    css('.has-cursor, .has-cursor *').styles(raw: {'cursor': 'none !important'}),
  ];
}

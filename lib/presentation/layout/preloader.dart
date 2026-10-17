// Intro curtain — a black frame with the monogram, a 0→100 counter and a
// progress hairline; then it wipes up (with a curved bottom edge) and the
// hero lines rise underneath.
//
// Only rendered visible under `html.js`. A CSS failsafe animation lifts it
// after 6s regardless, and `.reveal-all` hides it instantly.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../data/profile_data.dart';
import '../widgets/brand_mark.dart';

class Preloader extends StatelessComponent {
  const Preloader({super.key});

  @override
  Component build(BuildContext context) {
    final year = DateTime.now().year;
    return div(
      classes: 'preloader',
      attributes: const {'data-preloader': '', 'aria-hidden': 'true'},
      [
        div(classes: 'preloader__top label', [
          span([Component.text(ProfileData.name)]),
          span([Component.text('Portfolio ©$year')]),
        ]),
        div(classes: 'preloader__center', [
          const BrandMark(classes: 'preloader__mark'),
          span(classes: 'preloader__role', [
            span([Component.text('${ProfileData.role} — ${ProfileData.subRole}')]),
          ]),
        ]),
        div(classes: 'preloader__bottom', [
          span(classes: 'label', [Component.text(ProfileData.location)]),
          span(classes: 'preloader__count', [
            span(attributes: const {'data-preloader-count': ''}, [Component.text('0')]),
            span(classes: 'preloader__pct', [Component.text('%')]),
          ]),
        ]),
        span(classes: 'preloader__bar', attributes: const {'data-preloader-bar': ''}, []),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.preloader').styles(raw: {'display': 'none'}),
    css('.js .preloader').styles(raw: {
      'position': 'fixed',
      'inset': '0',
      'z-index': '9500',
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': 'space-between',
      'padding': 'clamp(1.25rem, 3vw, 2.25rem) var(--gutter)',
      'background': '#050506',
      'color': '#EDEDF0',
      'transition':
          'transform 1.15s var(--ease-in-out), border-radius 1.15s var(--ease-in-out)',
      'animation': 'preloader-failsafe 1s var(--ease-in-out) 6s forwards',
    }),
    css('.preloader.is-done').styles(raw: {
      'transform': 'translate3d(0, -100%, 0)',
      'border-radius': '0 0 50% 50% / 0 0 22vh 22vh',
    }),
    css('.reveal-all .preloader').styles(raw: {'display': 'none'}),
    css('.preloader .label').styles(raw: {'color': 'rgba(237, 237, 240, 0.55)'}),
    css('.preloader__top, .preloader__bottom').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
      'align-items': 'flex-end',
      'gap': '1rem',
    }),
    css('.preloader__center').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
      'gap': '1.5rem',
    }),
    css('.preloader__mark').styles(raw: {
      'width': 'clamp(4.5rem, 9vw, 7rem)',
      'animation': 'preloader-mark 1.4s var(--ease-expo) both',
    }),
    css.keyframes('preloader-mark', const {
      '0%': Styles(raw: {'opacity': '0', 'transform': 'scale(0.8)', 'filter': 'blur(10px)'}),
      '100%': Styles(raw: {'opacity': '1', 'transform': 'none', 'filter': 'blur(0)'}),
    }),
    css('.preloader__role').styles(raw: {
      'display': 'block',
      'overflow': 'hidden',
      'font-family': 'var(--font-mono)',
      'font-size': '0.75rem',
      'letter-spacing': '0.14em',
      'text-transform': 'uppercase',
      'color': 'rgba(237, 237, 240, 0.7)',
    }),
    css('.preloader__role span').styles(raw: {
      'display': 'block',
      'animation': 'rise 1.1s var(--ease-expo) 0.25s both',
    }),
    css('.preloader__count').styles(raw: {
      'display': 'flex',
      'align-items': 'flex-start',
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(4.5rem, 15vw, 13rem)',
      'font-weight': '500',
      'line-height': '0.8',
      'letter-spacing': '-0.06em',
      'font-variant-numeric': 'tabular-nums',
    }),
    css('.preloader__pct').styles(raw: {
      'font-size': '0.3em',
      'margin': '0.1em 0 0 0.15em',
      'color': 'rgba(237, 237, 240, 0.5)',
    }),
    css('.preloader__bar').styles(raw: {
      'position': 'absolute',
      'left': '0',
      'right': '0',
      'bottom': '0',
      'height': '2px',
      'background': 'var(--brand-gradient)',
      'transform': 'scaleX(0)',
      'transform-origin': 'left',
    }),
  ];
}

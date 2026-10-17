// Fixed top navigation.
//
//   [AB  Abdelkader Barhoumi]   ( About  Work  Experience … )   [Let's talk →]
//
// - The brand uses `mix-blend-mode: difference`, so it stays legible over
//   both the dark page and the light paper section.
// - The link pill has a sliding highlight (`[data-nav-indicator]`) that
//   ScrollSpy moves under the active link.
// - Hides while scrolling down, reappears on scroll up.
// - Below 1024px the links collapse into the burger → MobileMenu.
//
// All behavior lives in animation_scripts.dart — no @client hydration.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../data/profile_data.dart';
import '../widgets/brand_mark.dart';
import '../widgets/pill_button.dart';

class Navbar extends StatelessComponent {
  const Navbar({super.key});

  @override
  Component build(BuildContext context) {
    return header(classes: 'nav', attributes: const {'data-nav': ''}, [
      div(classes: 'nav__inner container', [
        a(
          href: AppAnchors.hash(AppAnchors.home),
          classes: 'nav__brand',
          attributes: const {'aria-label': '${ProfileData.name} — home'},
          [
            const BrandMark(classes: 'nav__mark'),
            span(classes: 'nav__name', [
              span([Component.text(ProfileData.firstName)]),
              span([Component.text(ProfileData.lastName)]),
            ]),
          ],
        ),
        nav(classes: 'nav__links', attributes: const {'aria-label': 'Primary'}, [
          span(classes: 'nav__indicator', attributes: const {'data-nav-indicator': ''}, []),
          for (final item in AppAnchors.items)
            a(
              href: AppAnchors.hash(item.id),
              classes: 'nav__link',
              attributes: const {'data-nav-link': ''},
              [Component.text(item.label)],
            ),
        ]),
        div(classes: 'nav__right', [
          span(classes: 'nav__cta', [
            PillButton(
              label: 'Let\'s talk',
              href: AppAnchors.hash(AppAnchors.contact),
              small: true,
            ),
          ]),
          button(
            type: ButtonType.button,
            classes: 'nav__burger',
            attributes: const {
              'data-menu-toggle': '',
              'aria-expanded': 'false',
              'aria-controls': 'menu',
              'aria-label': 'Open menu',
            },
            [span([]), span([])],
          ),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.nav').styles(raw: {
      'position': 'fixed',
      'top': '0',
      'left': '0',
      'right': '0',
      'z-index': '1000',
      'height': 'var(--nav-h)',
      'transition': 'transform 0.8s var(--ease-expo)',
    }),
    css('.nav.is-hidden').styles(raw: {'transform': 'translate3d(0, -110%, 0)'}),
    css('.nav__inner').styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'space-between',
      'gap': '1rem',
      'height': '100%',
    }),

    // ----- Brand -----
    css('.nav__brand').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.8rem',
      'color': '#FFFFFF',
      'mix-blend-mode': 'difference',
    }),
    css('.nav__mark').styles(raw: {
      'width': '2.7rem',
      'transition': 'transform 0.8s var(--ease-expo)',
    }),
    css('.nav__brand:hover .nav__mark').styles(raw: {'transform': 'rotate(-8deg) scale(1.05)'}),
    css('.nav__name').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'font-family': 'var(--font-display)',
      'font-size': '0.86rem',
      'font-weight': '500',
      'line-height': '1.1',
      'letter-spacing': '-0.01em',
    }),

    // ----- Link pill -----
    css('.nav__links').styles(raw: {
      'position': 'relative',
      'display': 'none',
      'padding': '5px',
      'border': '1px solid rgba(255, 255, 255, 0.09)',
      'border-radius': '999px',
      'background': 'rgba(16, 16, 20, 0.62)',
      'backdrop-filter': 'blur(16px) saturate(150%)',
      '-webkit-backdrop-filter': 'blur(16px) saturate(150%)',
    }),
    css('.nav__link').styles(raw: {
      'position': 'relative',
      'z-index': '1',
      'padding': '0.6rem 1.05rem',
      'border-radius': '999px',
      'font-size': '0.86rem',
      'color': 'rgba(237, 237, 240, 0.62)',
      'transition': 'color 0.4s var(--ease-out)',
    }),
    css('.nav__link:hover, .nav__link.is-active').styles(raw: {'color': '#FFFFFF'}),
    css('.nav__indicator').styles(raw: {
      'position': 'absolute',
      'top': '5px',
      'bottom': '5px',
      'left': '0',
      'width': '0',
      'border-radius': '999px',
      'background': 'rgba(255, 255, 255, 0.1)',
      'opacity': '0',
      'transition':
          'transform 0.7s var(--ease-expo), width 0.7s var(--ease-expo), '
          'opacity 0.4s var(--ease-out)',
    }),

    // ----- Right side -----
    css('.nav__right').styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'gap': '0.6rem',
    }),
    css('.nav__cta').styles(raw: {'display': 'none'}),
    css('.nav__cta .btn--solid').styles(raw: {
      'background': '#EDEDF0',
      'color': '#09090B',
      'box-shadow': '0 10px 30px -10px rgba(0, 0, 0, 0.5)',
    }),
    css('.nav__cta .btn--solid .btn__icon').styles(raw: {
      'background': '#09090B',
      'color': '#EDEDF0',
    }),
    css('.nav__burger').styles(raw: {
      'position': 'relative',
      'z-index': '2',
      'display': 'inline-flex',
      'flex-direction': 'column',
      'justify-content': 'center',
      'align-items': 'center',
      'gap': '6px',
      'width': '3rem',
      'height': '3rem',
      'border': '1px solid rgba(255, 255, 255, 0.1)',
      'border-radius': '50%',
      'background': 'rgba(16, 16, 20, 0.62)',
      'backdrop-filter': 'blur(16px)',
      '-webkit-backdrop-filter': 'blur(16px)',
    }),
    css('.nav__burger span').styles(raw: {
      'display': 'block',
      'width': '18px',
      'height': '1.5px',
      'background': '#EDEDF0',
      'transition': 'transform 0.6s var(--ease-expo)',
    }),
    css('.menu-open .nav__burger span:first-child').styles(raw: {
      'transform': 'translateY(3.75px) rotate(45deg)',
    }),
    css('.menu-open .nav__burger span:last-child').styles(raw: {
      'transform': 'translateY(-3.75px) rotate(-45deg)',
    }),

    css.media(minWidth(AppSpacing.bpLg), [
      css('.nav__links').styles(raw: {'display': 'flex'}),
      css('.nav__cta').styles(raw: {'display': 'inline-flex'}),
      css('.nav__burger').styles(raw: {'display': 'none'}),
    ]),
    css.media(MediaQuery.raw('(min-width: ${AppSpacing.bpLg}px) and (max-width: 1180px)'), [
      css('.nav__name').styles(raw: {'display': 'none'}),
      css('.nav__link').styles(raw: {'padding': '0.6rem 0.8rem'}),
    ]),
  ];
}

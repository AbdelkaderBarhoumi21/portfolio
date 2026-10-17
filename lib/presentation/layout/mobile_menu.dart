// Full-screen menu for < 1024px. Opened by the navbar burger
// (`[data-menu-toggle]`); the motion script toggles `html.menu-open`,
// which wipes the panel down and staggers the big links up.
//
// Starts `inert` + aria-hidden so its links aren't focusable while closed.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../data/profile_data.dart';
import '../widgets/social_icon.dart';

class MobileMenu extends StatelessComponent {
  const MobileMenu({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      id: 'menu',
      classes: 'menu',
      attributes: const {'data-menu': '', 'aria-hidden': 'true', 'inert': '', 'data-lenis-prevent': ''},
      [
        nav(classes: 'menu__links', attributes: const {'aria-label': 'Mobile'}, [
          for (var i = 0; i < AppAnchors.items.length; i++)
            a(
              href: AppAnchors.hash(AppAnchors.items[i].id),
              classes: 'menu__link',
              attributes: {'data-menu-link': '', 'style': '--i: $i'},
              [
                span(classes: 'menu__link-inner', [
                  span(classes: 'label menu__idx', [
                    Component.text((i + 1).toString().padLeft(2, '0')),
                  ]),
                  span(classes: 'menu__label', [Component.text(AppAnchors.items[i].label)]),
                ]),
              ],
            ),
        ]),
        div(classes: 'menu__foot', [
          a(href: ProfileData.mailto, classes: 'menu__email', [
            Component.text(ProfileData.email),
          ]),
          div(classes: 'socials', [
            for (final s in ProfileData.socials) SocialIcon(link: s),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.menu').styles(raw: {
      'position': 'fixed',
      'inset': '0',
      'z-index': '990',
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': 'space-between',
      'gap': '2rem',
      'padding': 'calc(var(--nav-h) + 2rem) var(--gutter) 2rem',
      'background': 'var(--bg-raised)',
      'clip-path': 'inset(0 0 100% 0)',
      'visibility': 'hidden',
      'transition': 'clip-path 0.9s var(--ease-in-out), visibility 0s linear 0.9s',
      'overflow-y': 'auto',
    }),
    css('.menu-open .menu').styles(raw: {
      'clip-path': 'inset(0 0 0 0)',
      'visibility': 'visible',
      'transition': 'clip-path 0.9s var(--ease-in-out), visibility 0s linear 0s',
    }),
    css('.menu__links').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
    }),
    css('.menu__link').styles(raw: {
      'display': 'block',
      'overflow': 'hidden',
      'padding-block': '0.15rem',
      'border-bottom': '1px solid var(--line)',
    }),
    css('.menu__link-inner').styles(raw: {
      'display': 'flex',
      'align-items': 'baseline',
      'gap': '1rem',
      'transform': 'translate3d(0, 110%, 0)',
      'transition': 'transform 0.9s var(--ease-expo)',
      'transition-delay': 'calc(0.25s + var(--i) * 60ms)',
    }),
    css('.menu-open .menu__link-inner').styles(raw: {'transform': 'none'}),
    css('.menu__label').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(2.4rem, 10.5vw, 4.5rem)',
      'font-weight': '500',
      'line-height': '1.1',
      'letter-spacing': '-0.045em',
      'color': 'var(--text)',
    }),
    css('.menu__link.is-active .menu__label').styles(raw: {
      'font-family': 'var(--font-serif)',
      'font-style': 'italic',
      'font-weight': '400',
    }),
    css('.menu__foot').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '1.25rem',
      'opacity': '0',
      'transition': 'opacity 0.6s var(--ease-out)',
    }),
    css('.menu-open .menu__foot').styles(raw: {
      'opacity': '1',
      'transition-delay': '0.6s',
    }),
    css('.menu__email').styles(raw: {
      'font-size': '1.05rem',
      'color': 'var(--text)',
    }),
  ];
}

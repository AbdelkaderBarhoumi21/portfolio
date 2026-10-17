// Footer — sign-off columns, a giant parallax wordmark, and the legal line.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../core/constants/ui_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../data/profile_data.dart';
import '../widgets/local_clock.dart';
import '../widgets/social_icon.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    final year = DateTime.now().year;
    return footer(classes: 'footer', [
      div(classes: 'container', [
        div(classes: 'footer__top', [
          div(classes: 'footer__col', [
            span(classes: 'label', [Component.text('Say hello')]),
            a(href: ProfileData.mailto, classes: 'footer__email hover-line', [
              Component.text(ProfileData.email),
            ]),
            div(classes: 'socials', [
              for (final s in ProfileData.socials) SocialIcon(link: s),
            ]),
          ]),
          nav(classes: 'footer__col', attributes: const {'aria-label': 'Footer'}, [
            span(classes: 'label', [Component.text('Sitemap')]),
            for (final item in AppAnchors.items)
              a(href: AppAnchors.hash(item.id), classes: 'footer__link', [
                span(classes: 'hover-line', [Component.text(item.label)]),
              ]),
          ]),
          div(classes: 'footer__col', [
            span(classes: 'label', [Component.text('Local time')]),
            span(classes: 'footer__time', [
              const LocalClock(timeZone: ProfileData.timeZone),
              span(classes: 'label', [Component.text(' ${ProfileData.timeZoneLabel}')]),
            ]),
            span(classes: 'footer__place', [Component.text(ProfileData.location)]),
          ]),
        ]),
      ]),
      div(
        classes: 'footer__wordmark-wrap',
        attributes: const {'data-parallax-root': '', 'aria-hidden': 'true'},
        [
          span(
            classes: 'footer__wordmark',
            attributes: const {'data-parallax': '0.18'},
            [Component.text(ProfileData.lastName)],
          ),
        ],
      ),
      div(classes: 'container', [
        div(classes: 'footer__bottom label', [
          span([Component.text('© $year ${ProfileData.name}')]),
          span([Component.text('Designed & built with Dart · Jaspr')]),
          a(href: AppAnchors.hash(AppAnchors.home), classes: 'footer__top-link', [
            Component.text('Back to top'),
            RawText(UiIcons.arrowUp),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.footer').styles(raw: {
      'position': 'relative',
      'overflow': 'hidden',
      'padding-top': 'clamp(3.5rem, 7vw, 6rem)',
      'border-top': '1px solid var(--line)',
    }),
    css('.footer__top').styles(raw: {
      'display': 'grid',
      'gap': '2.5rem',
    }),
    css('.footer__col').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'flex-start',
      'gap': '0.8rem',
    }),
    css('.footer__email').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(1.15rem, 1.8vw, 1.6rem)',
      'letter-spacing': '-0.02em',
      'color': 'var(--text)',
      'overflow-wrap': 'anywhere',
    }),
    css('.footer__email + .socials').styles(raw: {'margin-top': '0.5rem'}),
    css('.footer__link').styles(raw: {
      'color': 'var(--text-dim)',
      'transition': 'color 0.3s var(--ease-out)',
    }),
    css('.footer__link:hover').styles(raw: {'color': 'var(--text)'}),
    css('.footer__time').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(2rem, 3vw, 2.75rem)',
      'letter-spacing': '-0.04em',
      'line-height': '1',
      'color': 'var(--text)',
    }),
    css('.footer__place').styles(raw: {'color': 'var(--text-dim)'}),
    css('.footer__wordmark-wrap').styles(raw: {
      'display': 'flex',
      'justify-content': 'center',
      'margin-top': 'clamp(1rem, 3vw, 2.5rem)',
      'padding-top': '5vw',
      'overflow': 'hidden',
      'pointer-events': 'none',
      'user-select': 'none',
    }),
    css('.footer__wordmark').styles(raw: {
      'display': 'block',
      'font-family': 'var(--font-display)',
      'font-size': '20vw',
      'font-weight': '600',
      'line-height': '0.9',
      'letter-spacing': '-0.04em',
      'white-space': 'nowrap',
      'padding-right': '0.06em',
      'color': 'transparent',
      'background': 'linear-gradient(180deg, var(--text-faint) 0%, transparent 92%)',
      '-webkit-background-clip': 'text',
      'background-clip': 'text',
    }),
    css('.footer__bottom').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'justify-content': 'space-between',
      'gap': '0.75rem 2rem',
      'padding-block': '1.5rem',
      'border-top': '1px solid var(--line)',
    }),
    css('.footer__top-link').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4rem',
      'color': 'var(--text)',
    }),
    css.media(minWidth(AppSpacing.bpMd), [
      css('.footer__top').styles(raw: {
        'grid-template-columns': 'minmax(0, 1.6fr) minmax(0, 1fr) minmax(0, 1fr)',
      }),
    ]),
  ];
}

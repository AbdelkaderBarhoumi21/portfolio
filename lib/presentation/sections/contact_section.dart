// Contact — the closing shot.
//
//   (07) CONTACT ───────────────────────────────────────
//   Let's build
//   something great.                      (giant, line reveal)
//
//   Availability copy.                    Email      abdel…@gmail.com ↗
//   abdelkader…@gmail.com  ↗              Phone      +216 …
//   [Copy email] [Download CV]            LinkedIn   in/…
//                                         GitHub     …

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../core/constants/ui_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../data/profile_data.dart';
import '../widgets/pill_button.dart';
import '../widgets/split_lines.dart';

class ContactSection extends StatelessComponent {
  const ContactSection({super.key});

  @override
  Component build(BuildContext context) {
    final rows = [
      (label: 'Email', value: ProfileData.email, href: ProfileData.mailto, external: false),
      (label: 'Phone', value: ProfileData.phone, href: ProfileData.telHref, external: false),
      (label: 'LinkedIn', value: ProfileData.linkedinHandle, href: ProfileData.linkedin, external: true),
      (label: 'GitHub', value: ProfileData.githubHandle, href: ProfileData.github, external: true),
    ];

    return section(id: AppAnchors.contact, classes: 'section contact', [
      div(classes: 'contact__glow', attributes: const {'aria-hidden': 'true'}, []),
      div(classes: 'container', [
        div(classes: 'shead__meta', [
          span(classes: 'label shead__index', [Component.text('(07)')]),
          span(classes: 'label', [Component.text('Contact')]),
          span(
            classes: 'shead__rule',
            attributes: const {'data-reveal': 'line', 'aria-hidden': 'true'},
            [],
          ),
        ]),
        const SplitLines(['Let\'s build', 'something _great._'], classes: 'contact__title'),

        div(classes: 'contact__grid', [
          div(classes: 'contact__main', attributes: const {'data-reveal': ''}, [
            p(classes: 'contact__lede', [Component.text(ProfileData.availability)]),
            a(
              href: ProfileData.mailto,
              classes: 'contact__email',
              attributes: const {'data-cursor': 'Say hi'},
              [
                span(classes: 'hover-line', [Component.text(ProfileData.email)]),
                span(classes: 'contact__email-icon', [RawText(UiIcons.arrowUpRight)]),
              ],
            ),
            div(classes: 'contact__actions', [
              button(
                type: ButtonType.button,
                classes: 'copy-btn',
                attributes: const {
                  'data-copy': ProfileData.email,
                  'data-copied': 'Copied to clipboard',
                },
                [
                  span(classes: 'copy-btn__icon', [RawText(UiIcons.copy)]),
                  span(attributes: const {'data-copy-label': ''}, [Component.text('Copy email')]),
                ],
              ),
              PillButton(
                label: 'Download CV',
                href: ProfileData.cvPath,
                variant: PillVariant.ghost,
                icon: UiIcons.download,
                download: true,
              ),
            ]),
          ]),
          dl(classes: 'contact__list', [
            for (var i = 0; i < rows.length; i++)
              div(
                classes: 'contact__row',
                attributes: {'data-reveal': '', 'style': '--d: ${i * 80}ms'},
                [
                  dt(classes: 'label', [Component.text(rows[i].label)]),
                  dd([
                    a(
                      href: rows[i].href,
                      target: rows[i].external ? Target.blank : null,
                      attributes: rows[i].external ? const {'rel': 'noopener noreferrer'} : null,
                      [
                        span(classes: 'hover-line', [Component.text(rows[i].value)]),
                        span(classes: 'contact__row-icon', [RawText(UiIcons.arrowUpRight)]),
                      ],
                    ),
                  ]),
                ],
              ),
            div(
              classes: 'contact__row',
              attributes: const {'data-reveal': '', 'style': '--d: 320ms'},
              [
                dt(classes: 'label', [Component.text('Location')]),
                dd([Component.text(ProfileData.location)]),
              ],
            ),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.contact').styles(raw: {
      'overflow': 'hidden',
      'padding-bottom': 'clamp(4rem, 9vw, 8rem)',
    }),
    css('.contact__glow').styles(raw: {
      'position': 'absolute',
      'left': '50%',
      'bottom': '-35vw',
      'width': '90vw',
      'height': '60vw',
      'transform': 'translateX(-50%)',
      'border-radius': '50%',
      'background':
          'radial-gradient(closest-side, '
          'color-mix(in srgb, var(--primary) 34%, transparent), transparent)',
      'filter': 'blur(30px)',
      'pointer-events': 'none',
    }),
    css('.contact .container').styles(raw: {'position': 'relative'}),
    css('.contact__title').styles(raw: {
      'font-size': 'clamp(3.2rem, 11.5vw, 12rem)',
      'line-height': '0.88',
      'letter-spacing': '-0.06em',
    }),
    css('.contact__grid').styles(raw: {
      'display': 'grid',
      'gap': '3.5rem',
      'margin-top': 'clamp(3rem, 7vw, 6rem)',
    }),
    css('.contact__lede').styles(raw: {
      'max-width': '44ch',
      'font-size': 'var(--fs-body-lg)',
    }),
    css('.contact__email').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4em',
      'margin-top': '1.75rem',
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(1.15rem, 2.4vw, 2.45rem)',
      'font-weight': '500',
      'letter-spacing': '-0.035em',
      'color': 'var(--text)',
      'overflow-wrap': 'anywhere',
    }),
    css('.contact__email-icon').styles(raw: {
      'display': 'inline-flex',
      'flex-shrink': '0',
      'color': 'var(--primary)',
      'transition': 'transform 0.6s var(--ease-expo)',
    }),
    css('.contact__email:hover .contact__email-icon').styles(raw: {
      'transform': 'translate(0.12em, -0.12em)',
    }),
    css('.contact__actions').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'gap': '0.75rem',
      'margin-top': '2rem',
    }),
    css('.copy-btn').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.6rem',
      'height': '3.4rem',
      'padding': '0 1.4rem',
      'border-radius': '999px',
      'background': 'var(--text)',
      'color': 'var(--bg)',
      'font-size': '0.95rem',
      'font-weight': '500',
      'transition': 'background 0.4s var(--ease-out), color 0.4s var(--ease-out)',
    }),
    css('.copy-btn:hover').styles(raw: {'background': 'var(--primary)', 'color': '#FFFFFF'}),
    css('.copy-btn.is-copied').styles(raw: {'background': 'var(--success)', 'color': '#0B0B0E'}),
    css('.copy-btn__icon').styles(raw: {'display': 'inline-flex'}),
    css('.contact__list').styles(raw: {'border-top': '1px solid var(--line)'}),
    css('.contact__row').styles(raw: {
      'display': 'grid',
      'grid-template-columns': '6.5rem minmax(0, 1fr)',
      'align-items': 'baseline',
      'gap': '1rem',
      'padding-block': '1.15rem',
      'border-bottom': '1px solid var(--line)',
    }),
    css('.contact__row dd').styles(raw: {
      'color': 'var(--text)',
      'overflow-wrap': 'anywhere',
    }),
    css('.contact__row a').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4rem',
    }),
    css('.contact__row-icon').styles(raw: {
      'display': 'inline-flex',
      'color': 'var(--text-faint)',
      'transition': 'color 0.4s var(--ease-out), transform 0.6s var(--ease-expo)',
    }),
    css('.contact__row a:hover .contact__row-icon').styles(raw: {
      'color': 'var(--text)',
      'transform': 'translate(2px, -2px)',
    }),
    css.media(maxWidth(AppSpacing.bpSm), [
      css('.contact__row').styles(raw: {
        'grid-template-columns': '5.25rem minmax(0, 1fr)',
        'font-size': '0.92rem',
      }),
    ]),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.contact__grid').styles(raw: {
        'grid-template-columns': 'minmax(0, 1.25fr) minmax(0, 1fr)',
        'align-items': 'end',
        'gap': '6vw',
      }),
    ]),
  ];
}

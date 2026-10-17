// Above-the-fold hero — the opening shot.
//
//   ● Available for new projects               Based in Tunis — 14:32 GMT+1
//
//   Abdelkader
//          Barhoumi                        (giant, line-masked reveal)
//
//   Mobile Software Engineer      I lead the mobile department…   Scroll
//   — Flutter Developer ↻         [View work →] [Download CV ↓]      │
//
// Everything here carries `data-load`, so it plays the moment the
// preloader curtain lifts. On scroll, GSAP drifts the content up and fades
// it while the drifting gradient orbs zoom — a slow camera pull-back.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../core/constants/ui_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../data/profile_data.dart';
import '../widgets/local_clock.dart';
import '../widgets/pill_button.dart';
import '../widgets/split_lines.dart';

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: AppAnchors.home,
      classes: 'hero',
      attributes: const {'data-hero': ''},
      [
        // ----- Background: drifting orbs + faint column grid -----
        div(classes: 'hero__bg', attributes: const {'data-hero-bg': '', 'aria-hidden': 'true'}, [
          div(classes: 'hero__orb hero__orb--a', []),
          div(classes: 'hero__orb hero__orb--b', []),
          div(classes: 'hero__cols', []),
        ]),

        div(classes: 'hero__inner container', attributes: const {'data-hero-inner': ''}, [
          // ----- Top row -----
          div(classes: 'hero__top', [
            span(
              classes: 'status',
              attributes: const {'data-reveal': 'fade', 'data-load': '', 'style': '--d: 150ms'},
              [
                span(classes: 'status__dot', []),
                Component.text(ProfileData.status),
              ],
            ),
            span(
              classes: 'label hero__where',
              attributes: const {'data-reveal': 'fade', 'data-load': '', 'style': '--d: 250ms'},
              [
                Component.text('Based in ${ProfileData.location} — '),
                const LocalClock(timeZone: ProfileData.timeZone),
                Component.text(' ${ProfileData.timeZoneLabel}'),
              ],
            ),
          ]),

          // ----- Name -----
          h1(classes: 'hero__title', [
            span(classes: 'sr-only', [Component.text(ProfileData.name)]),
            SplitLines.custom(
              [
                [Component.text(ProfileData.firstName)],
                [em(classes: 'serif', [Component.text(ProfileData.lastName)])],
              ],
              tag: SplitTag.span,
              classes: 'hero__name',
              onLoad: true,
              ariaHidden: true,
            ),
          ]),

          // ----- Bottom row -----
          div(classes: 'hero__bottom', [
            SplitLines.custom(
              [
                [Component.text(ProfileData.role)],
                [
                  Component.text('— '),
                  span(classes: 'rotator', attributes: const {'data-rotator': ''}, [
                    for (var i = 0; i < ProfileData.heroRoles.length; i++)
                      span(
                        classes: i == 0 ? 'rotator__item serif is-active' : 'rotator__item serif',
                        attributes: i == 0 ? null : const {'aria-hidden': 'true'},
                        [Component.text(ProfileData.heroRoles[i])],
                      ),
                  ]),
                ],
              ],
              tag: SplitTag.p,
              classes: 'hero__role',
              onLoad: true,
              delayMs: 450,
            ),
            div(classes: 'hero__pitch', [
              p(
                classes: 'hero__intro',
                attributes: const {'data-reveal': '', 'data-load': '', 'style': '--d: 600ms'},
                [Component.text(ProfileData.heroIntro)],
              ),
              div(
                classes: 'hero__ctas',
                attributes: const {'data-reveal': '', 'data-load': '', 'style': '--d: 720ms'},
                [
                  PillButton(label: 'View selected work', href: AppAnchors.hash(AppAnchors.work)),
                  PillButton(
                    label: 'Download CV',
                    href: ProfileData.cvPath,
                    variant: PillVariant.ghost,
                    icon: UiIcons.download,
                    download: true,
                  ),
                ],
              ),
            ]),
            a(
              href: AppAnchors.hash(AppAnchors.about),
              classes: 'hero__scroll',
              attributes: const {
                'aria-label': 'Scroll to about',
                'data-reveal': 'fade',
                'data-load': '',
                'style': '--d: 900ms',
              },
              [
                span(classes: 'label', [Component.text('Scroll')]),
                span(classes: 'hero__scroll-line', []),
              ],
            ),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero').styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'min-height': '100svh',
      'overflow': 'hidden',
      'padding': 'calc(var(--nav-h) + 1.5rem) 0 clamp(1.5rem, 3vw, 2.5rem)',
    }),

    // ----- Background -----
    css('.hero__bg').styles(raw: {
      'position': 'absolute',
      'inset': '0',
      'z-index': '0',
      'pointer-events': 'none',
      'transform-origin': '70% 40%',
    }),
    css('.hero__orb').styles(raw: {
      'position': 'absolute',
      'border-radius': '50%',
      'filter': 'blur(60px)',
      'animation': 'orb-drift 20s ease-in-out infinite',
      'translate': 'calc(var(--px, 0) * -40px) calc(var(--py, 0) * -40px)',
      'transition': 'translate 1.6s var(--ease-out)',
    }),
    css('.hero__orb--a').styles(raw: {
      'top': '-8vw',
      'right': '-14vw',
      'width': 'max(52vw, 420px)',
      'aspect-ratio': '1',
      'background':
          'radial-gradient(closest-side, '
          'color-mix(in srgb, var(--primary) 55%, transparent), transparent)',
      'opacity': '0.7',
    }),
    css('.hero__orb--b').styles(raw: {
      'bottom': '-18vw',
      'right': '16vw',
      'width': 'max(38vw, 320px)',
      'aspect-ratio': '1',
      'background':
          'radial-gradient(closest-side, '
          'color-mix(in srgb, var(--secondary) 38%, transparent), transparent)',
      'opacity': '0.55',
      'animation-duration': '26s',
      'animation-delay': '-8s',
    }),
    css('.hero__cols').styles(raw: {
      'position': 'absolute',
      'inset': '0',
      'background-image': 'linear-gradient(to right, var(--line) 1px, transparent 1px)',
      'background-size': 'calc(100% / 6) 100%',
      'background-position': 'calc(var(--gutter) * -1) 0',
      'mask-image': 'linear-gradient(to bottom, transparent, #000 25%, #000 70%, transparent)',
      '-webkit-mask-image': 'linear-gradient(to bottom, transparent, #000 25%, #000 70%, transparent)',
      'opacity': '0.55',
    }),

    // ----- Layout -----
    css('.hero__inner').styles(raw: {
      'position': 'relative',
      'z-index': '1',
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': 'space-between',
      'gap': 'clamp(2.5rem, 6vh, 4rem)',
      'will-change': 'transform, opacity',
    }),
    css('.hero__top').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'justify-content': 'space-between',
      'align-items': 'center',
      'gap': '1rem',
    }),
    css('.status').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.65rem',
      'padding': '0.55rem 1rem',
      'border': '1px solid var(--line-strong)',
      'border-radius': '999px',
      'background': 'rgba(255, 255, 255, 0.03)',
      'backdrop-filter': 'blur(10px)',
      '-webkit-backdrop-filter': 'blur(10px)',
      'font-size': '0.85rem',
      'color': 'var(--text)',
    }),
    css('.status__dot').styles(raw: {
      'width': '8px',
      'height': '8px',
      'border-radius': '50%',
      'background': 'var(--success)',
      'animation': 'pulse-dot 2.2s infinite',
    }),

    // ----- Name -----
    css('.hero__title').styles(raw: {
      'margin-top': 'auto',
      'font-weight': '500',
    }),
    css('.hero__name').styles(raw: {
      'display': 'block',
      'font-size': 'var(--fs-display)',
      'line-height': '0.86',
      'letter-spacing': '-0.06em',
    }),
    css('.hero__name .line:nth-child(2)').styles(raw: {
      'padding-left': '0.62em',
    }),
    css('.hero__name .serif').styles(raw: {
      'letter-spacing': '-0.035em',
      'background': 'linear-gradient(100deg, var(--text) 30%, color-mix(in srgb, var(--primary) 65%, var(--text)))',
      '-webkit-background-clip': 'text',
      'background-clip': 'text',
      'color': 'transparent',
      'padding-right': '0.08em',
    }),

    // ----- Bottom row -----
    css('.hero__bottom').styles(raw: {
      'display': 'grid',
      'gap': '1.75rem',
      'align-items': 'end',
    }),
    css('.hero__role').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(1.35rem, 2.1vw, 1.9rem)',
      'line-height': '1.15',
      'letter-spacing': '-0.025em',
      'color': 'var(--text)',
    }),
    css('.hero__role .serif').styles(raw: {'color': 'var(--text)'}),
    css('.hero__pitch').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '1.5rem',
    }),
    css('.hero__intro').styles(raw: {
      'max-width': '42ch',
      'font-size': 'var(--fs-body-lg)',
    }),
    css('.hero__ctas').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'gap': '0.75rem',
    }),

    // ----- Rotator -----
    css('.rotator').styles(raw: {
      'display': 'inline-grid',
      'vertical-align': 'bottom',
      'overflow': 'hidden',
      'transition': 'width 0.8s var(--ease-expo)',
    }),
    css('.rotator__item').styles(raw: {
      'grid-area': '1 / 1',
      'justify-self': 'start',
      'white-space': 'nowrap',
      'padding-right': '0.1em',
      'transform': 'translate3d(0, 110%, 0)',
      'transition': 'transform 0.9s var(--ease-expo)',
    }),
    css('.rotator__item.is-active').styles(raw: {'transform': 'none'}),
    css('.rotator__item.is-leaving').styles(raw: {'transform': 'translate3d(0, -110%, 0)'}),

    // ----- Scroll cue -----
    css('.hero__scroll').styles(raw: {
      'display': 'none',
      'flex-direction': 'column',
      'align-items': 'center',
      'gap': '0.85rem',
    }),
    css('.hero__scroll-line').styles(raw: {
      'width': '1px',
      'height': '4.5rem',
      'background': 'var(--text)',
      'animation': 'scroll-line 2.4s var(--ease-in-out) infinite',
    }),

    css.media(minWidth(AppSpacing.bpLg), [
      css('.hero__bottom').styles(raw: {
        'grid-template-columns': 'minmax(0, 1fr) minmax(0, 1.05fr) auto',
        'gap': '3rem',
      }),
      css('.hero__scroll').styles(raw: {'display': 'flex'}),
    ]),
    css.media(maxWidth(AppSpacing.bpSm), [
      css('.hero__where').styles(raw: {'display': 'none'}),
      css('.hero__name').styles(raw: {'font-size': '17.5vw'}),
      css('.hero__name .line:nth-child(2)').styles(raw: {'padding-left': '0.35em'}),
    ]),
  ];
}

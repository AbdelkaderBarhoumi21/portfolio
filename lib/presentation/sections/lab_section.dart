// Lab — personal projects.
//
// Desktop (≥1024 × 700, JS on): the section pins and vertical scrolling
// drives the track sideways — a horizontal "dolly" shot. The motion script
// adds `html.has-hscroll` only while that scene is active, so the
// horizontal layout never exists without the code that scrolls it.
// Everywhere else: a plain responsive grid.
//
// `data-spy="work"` keeps the "Work" nav link active through this section.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../data/projects_data.dart';
import '../widgets/lab_card.dart';
import '../widgets/split_lines.dart';

class LabSection extends StatelessComponent {
  const LabSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: AppAnchors.lab,
      classes: 'section lab',
      attributes: const {'data-spy': AppAnchors.work},
      [
        div(classes: 'lab__pin', attributes: const {'data-hscroll': ''}, [
          div(classes: 'lab__track', attributes: const {'data-hscroll-track': ''}, [
            div(classes: 'lab__intro', [
              div(classes: 'shead__meta', [
                span(classes: 'label shead__index', [Component.text('(03)')]),
                span(classes: 'label', [Component.text('Personal lab')]),
                span(
                  classes: 'shead__rule',
                  attributes: const {'data-reveal': 'line', 'aria-hidden': 'true'},
                  [],
                ),
              ]),
              const SplitLines(['Side projects', '& _experiments_'], classes: 'lab__title'),
              p(
                classes: 'lab__lede',
                attributes: const {'data-reveal': '', 'style': '--d: 200ms'},
                [
                  Component.text(
                    'Full-stack builds where I own every layer — from Rust, '
                    'Laravel and WebSocket backends to the Flutter client.',
                  ),
                ],
              ),
              span(classes: 'label lab__hint', attributes: const {'data-reveal': 'fade'}, [
                Component.text('Keep scrolling'),
                span(classes: 'lab__hint-line', []),
              ]),
            ]),
            for (var i = 0; i < projects.length; i++)
              LabCard(project: projects[i], index: i),
          ]),
          div(classes: 'lab__progress', attributes: const {'aria-hidden': 'true'}, [
            span(attributes: const {'data-hscroll-progress': ''}, []),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    // ----- Default: responsive grid ------------------------------------
    css('.lab__track').styles(raw: {
      'display': 'grid',
      'grid-template-columns': 'minmax(0, 1fr)',
      'gap': '1.25rem',
      'max-width': 'var(--container)',
      'margin-inline': 'auto',
      'padding-inline': 'var(--gutter)',
    }),
    css('.lab__intro').styles(raw: {
      'grid-column': '1 / -1',
      'margin-bottom': 'clamp(1.5rem, 4vw, 3rem)',
    }),
    css('.lab__title').styles(raw: {
      'font-size': 'var(--fs-h2)',
      'line-height': '0.94',
      'letter-spacing': '-0.048em',
    }),
    css('.lab__lede').styles(raw: {
      'margin-top': '1.5rem',
      'max-width': '36ch',
      'font-size': 'var(--fs-body-lg)',
    }),
    css('.lab__hint, .lab__progress').styles(raw: {'display': 'none'}),
    css.media(minWidth(AppSpacing.bpMd), [
      css('.lab__track').styles(raw: {
        'grid-template-columns': 'repeat(2, minmax(0, 1fr))',
      }),
    ]),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.lab__track').styles(raw: {
        'grid-template-columns': 'repeat(3, minmax(0, 1fr))',
      }),
    ]),

    // ----- Pinned horizontal mode --------------------------------------
    css('.has-hscroll .lab').styles(raw: {'padding-block': '0'}),
    css('.has-hscroll .lab__pin').styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'align-items': 'center',
      'height': '100vh',
      'overflow': 'hidden',
    }),
    css('.has-hscroll .lab__track').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'nowrap',
      'align-items': 'stretch',
      'gap': '1.75rem',
      'width': 'max-content',
      'max-width': 'none',
      'margin': '0',
      'padding': 'calc(var(--nav-h) * 0.6) var(--gutter) 0',
      'will-change': 'transform',
    }),
    css('.has-hscroll .lab__intro').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': 'center',
      'flex-shrink': '0',
      'width': 'clamp(380px, 38vw, 600px)',
      'margin': '0 3vw 0 0',
    }),
    css('.has-hscroll .lab-card').styles(raw: {
      'flex-shrink': '0',
      'width': 'clamp(400px, 34vw, 540px)',
    }),
    css('.has-hscroll .lab__hint').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '1rem',
      'margin-top': '2.5rem',
    }),
    css('.lab__hint-line').styles(raw: {
      'width': '4rem',
      'height': '1px',
      'background': 'var(--text)',
      'transform-origin': 'left',
      'animation': 'hint-line 2.4s var(--ease-in-out) infinite',
    }),
    css.keyframes('hint-line', const {
      '0%': Styles(raw: {'transform': 'scaleX(0)', 'transform-origin': 'left'}),
      '45%': Styles(raw: {'transform': 'scaleX(1)', 'transform-origin': 'left'}),
      '55%': Styles(raw: {'transform': 'scaleX(1)', 'transform-origin': 'right'}),
      '100%': Styles(raw: {'transform': 'scaleX(0)', 'transform-origin': 'right'}),
    }),
    css('.has-hscroll .lab__progress').styles(raw: {
      'display': 'block',
      'position': 'absolute',
      'left': 'var(--gutter)',
      'right': 'var(--gutter)',
      'bottom': '5vh',
      'height': '1px',
      'background': 'var(--line)',
    }),
    css('.lab__progress span').styles(raw: {
      'display': 'block',
      'height': '100%',
      'background': 'var(--text)',
      'transform': 'scaleX(0)',
      'transform-origin': 'left',
    }),
  ];
}

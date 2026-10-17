// One role in the experience list — an editorial three-column row:
//
//   APR 2026 — PRESENT  │ Oxton Digital            │ — bullet
//   ● NOW               │ Mobile Lead — Flutter…   │ — bullet
//                       │ TUNIS · FULL-TIME        │ chips
//
// A hairline draws in across the top as the row enters the viewport.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../domain/models/experience.dart';
import 'tech_chip.dart';

class ExperienceRow extends StatelessComponent {
  const ExperienceRow({required this.experience, super.key});

  final Experience experience;

  @override
  Component build(BuildContext context) {
    final x = experience;
    return article(classes: 'xp', [
      span(
        classes: 'xp__rule',
        attributes: const {'data-reveal': 'line', 'aria-hidden': 'true'},
        [],
      ),
      div(classes: 'xp__grid', attributes: const {'data-reveal': ''}, [
        div(classes: 'xp__when', [
          span(classes: 'label xp__period', [Component.text(x.period)]),
          if (x.current)
            span(classes: 'xp__now', [
              span(classes: 'xp__now-dot', []),
              Component.text('Now'),
            ]),
        ]),
        div(classes: 'xp__who', [
          h3(classes: 'xp__company', [Component.text(x.company)]),
          p(classes: 'xp__role', [Component.text(x.role)]),
          p(classes: 'label xp__meta', [
            Component.text('${x.location} · ${x.employment}'),
          ]),
        ]),
        div(classes: 'xp__what', [
          ul(classes: 'xp__bullets', [
            for (final b in x.bullets) li([Component.text(b)]),
          ]),
          ul(classes: 'chips xp__chips', [
            for (final t in x.tech) TechChip(t),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.xp').styles(raw: {
      'position': 'relative',
      'padding-block': 'clamp(2rem, 4vw, 3.25rem)',
    }),
    css('.xp__rule').styles(raw: {
      'position': 'absolute',
      'top': '0',
      'left': '0',
      'right': '0',
      'height': '1px',
      'background': 'var(--line-strong)',
    }),
    css('.xp__grid').styles(raw: {
      'display': 'grid',
      'gap': '1.25rem',
    }),
    css('.xp__when').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'align-items': 'center',
      'gap': '0.75rem',
    }),
    css('.xp__period').styles(raw: {'color': 'var(--text)'}),
    css('.xp__now').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.45rem',
      'padding': '0.3rem 0.7rem',
      'border-radius': '999px',
      'background': 'var(--text)',
      'color': 'var(--bg)',
      'font-family': 'var(--font-mono)',
      'font-size': '0.68rem',
      'letter-spacing': '0.12em',
      'text-transform': 'uppercase',
    }),
    css('.xp__now-dot').styles(raw: {
      'width': '6px',
      'height': '6px',
      'border-radius': '50%',
      'background': 'var(--success)',
      'animation': 'pulse-dot 2s infinite',
    }),
    css('.xp__company').styles(raw: {
      'font-size': 'var(--fs-h3)',
      'line-height': '1',
      'letter-spacing': '-0.045em',
      'transition': 'transform 0.7s var(--ease-expo)',
    }),
    css('.xp:hover .xp__company').styles(raw: {'transform': 'translateX(0.35rem)'}),
    css('.xp__role').styles(raw: {
      'margin-top': '0.7rem',
      'color': 'var(--text)',
      'font-weight': '500',
    }),
    css('.xp__meta').styles(raw: {'margin-top': '0.45rem'}),
    css('.xp__bullets').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.75rem',
    }),
    css('.xp__bullets li').styles(raw: {
      'position': 'relative',
      'padding-left': '1.5rem',
      'color': 'var(--text-dim)',
      'max-width': '62ch',
    }),
    css('.xp__bullets li::before').styles(raw: {
      'content': '""',
      'position': 'absolute',
      'left': '0',
      'top': '0.8em',
      'width': '0.7rem',
      'height': '1px',
      'background': 'var(--text)',
    }),
    css('.xp__chips').styles(raw: {'margin-top': '1.4rem'}),

    css.media(minWidth(AppSpacing.bpMd), [
      css('.xp__grid').styles(raw: {
        'grid-template-columns': 'minmax(0, 1fr) minmax(0, 1.5fr)',
        'column-gap': '3rem',
      }),
      css('.xp__when').styles(raw: {'grid-column': '1', 'grid-row': '1'}),
      css('.xp__who').styles(raw: {'grid-column': '1', 'grid-row': '2'}),
      css('.xp__what').styles(raw: {'grid-column': '2', 'grid-row': '1 / span 2'}),
    ]),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.xp__grid').styles(raw: {
        'grid-template-columns': 'minmax(0, 0.75fr) minmax(0, 1.15fr) minmax(0, 1.6fr)',
      }),
      css('.xp__when').styles(raw: {
        'grid-column': '1',
        'grid-row': '1',
        'flex-direction': 'column',
        'align-items': 'flex-start',
      }),
      css('.xp__who').styles(raw: {'grid-column': '2', 'grid-row': '1'}),
      css('.xp__what').styles(raw: {'grid-column': '3', 'grid-row': '1'}),
    ]),
  ];
}

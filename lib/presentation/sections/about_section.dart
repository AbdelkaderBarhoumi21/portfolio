// About — a scroll-scrubbed statement, short bio + facts, and stats.
//
//   (01) ABOUT ─────────────────────────────────────────
//   I build mobile products that feel effortless — …   (words light up)
//
//   Bio paragraphs                  Currently   Mobile Lead @ Oxton
//                                   Based in    Tunis, Tunisia …
//
//   05+          04           09          03
//   Apps…        Countries…   Certs…      Languages…

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../data/profile_data.dart';
import '../widgets/scrub_text.dart';
import '../widgets/stat_counter.dart';

class AboutSection extends StatelessComponent {
  const AboutSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(id: AppAnchors.about, classes: 'section about', [
      div(classes: 'container', [
        div(classes: 'shead__meta', [
          span(classes: 'label shead__index', [Component.text('(01)')]),
          span(classes: 'label', [Component.text('About')]),
          span(
            classes: 'shead__rule',
            attributes: const {'data-reveal': 'line', 'aria-hidden': 'true'},
            [],
          ),
        ]),

        const ScrubText(ProfileData.statement, classes: 'about__statement'),

        div(classes: 'about__grid', [
          div(classes: 'about__bio', [
            for (var i = 0; i < ProfileData.bio.length; i++)
              p(
                attributes: {'data-reveal': '', 'style': '--d: ${i * 120}ms'},
                [Component.text(ProfileData.bio[i])],
              ),
          ]),
          dl(classes: 'about__facts', [
            for (var i = 0; i < ProfileData.facts.length; i++)
              div(
                classes: 'about__fact',
                attributes: {'data-reveal': '', 'style': '--d: ${i * 80}ms'},
                [
                  dt(classes: 'label', [Component.text(ProfileData.facts[i].label)]),
                  dd([Component.text(ProfileData.facts[i].value)]),
                ],
              ),
          ]),
        ]),

        div(classes: 'about__stats', [
          for (var i = 0; i < ProfileData.stats.length; i++)
            StatCounter(stat: ProfileData.stats[i], delayMs: i * 100),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.about__statement').styles(raw: {
      'max-width': '27ch',
      'margin-block': 'clamp(1rem, 3vw, 2rem) clamp(4rem, 9vw, 8rem)',
    }),
    css('.about__grid').styles(raw: {
      'display': 'grid',
      'gap': '3rem',
    }),
    css('.about__bio').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '1.25rem',
      'max-width': '54ch',
    }),
    css('.about__bio p').styles(raw: {'font-size': 'var(--fs-body-lg)'}),
    css('.about__bio p:first-child').styles(raw: {'color': 'var(--text)'}),
    css('.about__facts').styles(raw: {'border-top': '1px solid var(--line)'}),
    css('.about__fact').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
      'align-items': 'baseline',
      'gap': '1.5rem',
      'padding-block': '1.1rem',
      'border-bottom': '1px solid var(--line)',
    }),
    css('.about__fact dd').styles(raw: {
      'color': 'var(--text)',
      'text-align': 'right',
    }),
    css('.about__stats').styles(raw: {
      'display': 'grid',
      'grid-template-columns': 'repeat(2, minmax(0, 1fr))',
      'gap': '2.5rem 1.5rem',
      'margin-top': 'clamp(4.5rem, 9vw, 8rem)',
      'padding-top': '0.5rem',
      'border-top': '1px solid var(--line)',
    }),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.about__grid').styles(raw: {
        'grid-template-columns': 'repeat(12, minmax(0, 1fr))',
      }),
      css('.about__bio').styles(raw: {'grid-column': '1 / span 6'}),
      css('.about__facts').styles(raw: {'grid-column': '8 / span 5'}),
      css('.about__stats').styles(raw: {
        'grid-template-columns': 'repeat(4, minmax(0, 1fr))',
      }),
    ]),
  ];
}

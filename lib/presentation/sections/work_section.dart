// Selected work — client products as a deck of sticky, stacking cards.
//
// On tall-enough desktop viewports (≥900 × 800) each `.work__item` is `position: sticky`
// with a slightly larger top offset than the previous one, so the cards
// pile up like a deck as you scroll; GSAP scales the covered card down and
// darkens it (animation_scripts.dart → "Stacked work cards"). Elsewhere the
// cards simply flow and fade up.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../data/featured_work_data.dart';
import '../widgets/section_header.dart';
import '../widgets/work_card.dart';

class WorkSection extends StatelessComponent {
  const WorkSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(id: AppAnchors.work, classes: 'section work', [
      div(classes: 'container', [
        const SectionHeader(
          index: '02',
          label: 'Selected work',
          title: ['Products I\'ve', '_shipped_ lately'],
          lede:
              'Client apps across fitness, entertainment, commerce and IoT — '
              'built in Flutter and native Android, live in the hands of users.',
        ),
        div(classes: 'work__stack', [
          for (var i = 0; i < featuredWork.length; i++)
            div(
              classes: 'work__item',
              attributes: {'data-stack-item': '', 'style': '--n: $i'},
              [
                div(
                  classes: 'work__reveal',
                  attributes: const {'data-reveal': 'scale'},
                  [WorkCard(project: featuredWork[i], index: i, total: featuredWork.length)],
                ),
              ],
            ),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.work__stack').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': 'clamp(1.5rem, 4vw, 3rem)',
    }),
    css.media(MediaQuery.raw('(min-width: 900px) and (min-height: 800px)'), [
      css('.work__stack').styles(raw: {'gap': '14vh', 'padding-bottom': '4vh'}),
      css('.work__item').styles(raw: {
        'position': 'sticky',
        'top': 'calc(var(--nav-h) + 0.5rem + var(--n) * 1.1rem)',
      }),
      css('.work__item .wcard').styles(raw: {
        'height': 'calc(100vh - var(--nav-h) - 5.5rem)',
        'max-height': '820px',
        'min-height': '620px',
      }),
    ]),
    // Medium-height screens: compact the card so it always fits the
    // viewport while sticky (the chips repeat in Experience anyway).
    css.media(MediaQuery.raw('(min-width: 900px) and (min-height: 800px) and (max-height: 920px)'), [
      css('.work__item .wcard__stack').styles(raw: {'display': 'none'}),
      css('.work__item .wcard__info').styles(raw: {'gap': '1.05rem'}),
      css('.work__item .wcard__title').styles(raw: {'font-size': 'clamp(2.4rem, 4.6vw, 4.6rem)'}),
      css('.work__item .wcard__hl li').styles(raw: {'padding': '0.65rem 0', 'font-size': '0.9rem'}),
    ]),
  ];
}

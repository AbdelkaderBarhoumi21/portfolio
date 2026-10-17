// Experience — a light "paper" panel in the dark page, for rhythm.
//
// `.theme-paper` swaps the color custom properties, so every widget inside
// (rows, chips, labels) recolors itself with no extra CSS.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../data/experience_data.dart';
import '../widgets/experience_row.dart';
import '../widgets/section_header.dart';

class ExperienceSection extends StatelessComponent {
  const ExperienceSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: AppAnchors.experience,
      classes: 'section experience theme-paper',
      [
        div(classes: 'container', [
          const SectionHeader(
            index: '04',
            label: 'Experience',
            title: ['Where I\'ve', 'been _building_'],
            lede:
                'Leading mobile at a Tunis studio while shipping contract work '
                'for teams in Dubai, Paris and Algiers.',
          ),
          div(classes: 'experience__list', [
            for (final x in experiences) ExperienceRow(experience: x),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.experience').styles(raw: {
      'border-radius': 'var(--radius-xl)',
      'margin-inline': 'clamp(0.5rem, 1vw, 1rem)',
    }),
    css('.experience__list').styles(raw: {
      'border-bottom': '1px solid var(--line-strong)',
    }),
  ];
}

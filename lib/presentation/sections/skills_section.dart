// Skills — capability groups as editorial rows, plus spoken languages.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../data/profile_data.dart';
import '../../data/skills_data.dart';
import '../widgets/section_header.dart';
import '../widgets/skill_row.dart';

class SkillsSection extends StatelessComponent {
  const SkillsSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(id: AppAnchors.skills, classes: 'section skills', [
      div(classes: 'container', [
        const SectionHeader(
          index: '05',
          label: 'Capabilities',
          title: ['The _toolkit_'],
          lede:
              'Flutter-first, native when it matters, and comfortable all the '
              'way down to the backend and the CI pipeline.',
        ),
        div(classes: 'skills__list', [
          for (var i = 0; i < skillGroups.length; i++)
            SkillRow(group: skillGroups[i], index: i),
          div(classes: 'skill', attributes: const {'data-reveal': ''}, [
            span(classes: 'label skill__idx', [
              Component.text((skillGroups.length + 1).toString().padLeft(2, '0')),
            ]),
            h3(classes: 'skill__title', [Component.text('Languages')]),
            ul(classes: 'skill__items skills__langs', [
              for (final l in ProfileData.languages) li([Component.text(l)]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.skills__list').styles(raw: {'border-bottom': '1px solid var(--line)'}),
    css('.skills__langs').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'gap': '0.5rem 2rem',
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(1.15rem, 1.6vw, 1.45rem)',
      'letter-spacing': '-0.02em',
      'color': 'var(--text)',
    }),
  ];
}

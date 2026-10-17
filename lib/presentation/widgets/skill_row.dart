// One capability group as an editorial row:
//
//   01   Mobile — Flutter        [Flutter] [Dart] [BLoC/Cubit] …
//
// Hovering slides the title and lights the index in the brand color.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../domain/models/skill_group.dart';
import 'tech_chip.dart';

class SkillRow extends StatelessComponent {
  const SkillRow({required this.group, required this.index, super.key});

  final SkillGroup group;
  final int index; // 0-based

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'skill',
      attributes: {'data-reveal': '', 'style': '--d: ${index * 70}ms'},
      [
        span(classes: 'label skill__idx', [
          Component.text((index + 1).toString().padLeft(2, '0')),
        ]),
        h3(classes: 'skill__title', [Component.text(group.title)]),
        ul(classes: 'chips skill__items', [
          for (final s in group.skills) TechChip(s, withIcon: true),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.skill').styles(raw: {
      'position': 'relative',
      'display': 'grid',
      'grid-template-columns': '2.5rem minmax(0, 1fr)',
      'gap': '1rem 1rem',
      'padding-block': 'clamp(1.75rem, 3vw, 2.5rem)',
      'border-top': '1px solid var(--line)',
    }),
    css('.skill__idx').styles(raw: {
      'padding-top': '0.6rem',
      'transition': 'color 0.4s var(--ease-out)',
    }),
    css('.skill:hover .skill__idx').styles(raw: {'color': 'var(--primary)'}),
    css('.skill__title').styles(raw: {
      'font-size': 'clamp(1.6rem, 3vw, 2.6rem)',
      'line-height': '1.05',
      'letter-spacing': '-0.04em',
      'transition': 'transform 0.7s var(--ease-expo)',
    }),
    css('.skill:hover .skill__title').styles(raw: {'transform': 'translateX(0.4rem)'}),
    css('.skill__items').styles(raw: {'grid-column': '2'}),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.skill').styles(raw: {
        'grid-template-columns': '4rem minmax(0, 0.9fr) minmax(0, 1.4fr)',
        'align-items': 'start',
        'gap': '2rem',
      }),
      css('.skill__items').styles(raw: {'grid-column': '3', 'padding-top': '0.35rem'}),
    ]),
  ];
}

// Small pill for a technology / tag, optionally with its logo.
//
//   TechChip('Flutter', withIcon: true)

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/tech_icons.dart';

class TechChip extends StatelessComponent {
  const TechChip(this.label, {this.withIcon = false, super.key});

  final String label;
  final bool withIcon;

  @override
  Component build(BuildContext context) {
    final icon = withIcon ? iconFor(label) : null;
    return li(classes: 'chip', [
      if (icon != null) span(classes: 'chip__icon', [RawText(icon)]),
      Component.text(label),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.chips').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'gap': '0.45rem',
    }),
    css('.chip').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.45rem',
      'padding': '0.4rem 0.8rem',
      'border': '1px solid var(--line)',
      'border-radius': '999px',
      'font-size': '0.8rem',
      'line-height': '1.2',
      'color': 'var(--text-dim)',
      'white-space': 'nowrap',
      'transition':
          'color 0.4s var(--ease-out), border-color 0.4s var(--ease-out), '
          'background 0.4s var(--ease-out)',
    }),
    css('.chip:hover').styles(raw: {
      'color': 'var(--text)',
      'border-color': 'var(--line-strong)',
    }),
    css('.chip__icon').styles(raw: {
      'display': 'inline-flex',
      'width': '0.95rem',
      'height': '0.95rem',
      'flex-shrink': '0',
    }),
    css('.chip__icon svg').styles(raw: {'width': '100%', 'height': '100%'}),
  ];
}

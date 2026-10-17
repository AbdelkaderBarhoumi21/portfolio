// Big headline number that counts up when scrolled into view.
//
// The static HTML already contains the final value, so it reads correctly
// without JavaScript; the motion script resets it to 0 and tweens it.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../domain/models/stat.dart';

class StatCounter extends StatelessComponent {
  const StatCounter({required this.stat, this.delayMs = 0, super.key});

  final Stat stat;
  final int delayMs;

  @override
  Component build(BuildContext context) {
    final padded = stat.value.toString().padLeft(stat.pad, '0');
    return div(
      classes: 'stat',
      attributes: {'data-reveal': '', 'style': '--d: ${delayMs}ms'},
      [
        div(classes: 'stat__value', [
          span(
            attributes: {
              'data-count': '${stat.value}',
              'data-pad': '${stat.pad}',
            },
            [Component.text(padded)],
          ),
          if (stat.suffix.isNotEmpty)
            span(classes: 'stat__suffix', [Component.text(stat.suffix)]),
        ]),
        p(classes: 'stat__label', [Component.text(stat.label)]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.stat').styles(raw: {
      'padding-top': '1.75rem',
    }),
    css('.stat__value').styles(raw: {
      'display': 'flex',
      'align-items': 'flex-start',
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(3.6rem, 8vw, 7.5rem)',
      'font-weight': '500',
      'line-height': '0.9',
      'letter-spacing': '-0.055em',
      'color': 'var(--text)',
      'font-variant-numeric': 'tabular-nums',
    }),
    css('.stat__suffix').styles(raw: {
      'font-size': '0.45em',
      'margin': '0.12em 0 0 0.08em',
      'color': 'var(--primary)',
    }),
    css('.stat__label').styles(raw: {
      'margin-top': '0.9rem',
      'max-width': '22ch',
      'font-size': 'var(--fs-small)',
    }),
  ];
}

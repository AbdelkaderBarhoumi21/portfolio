// Editorial section opener:
//
//   (02)  SELECTED WORK  ───────────────────────────────
//   Products I've                        Optional lede paragraph
//   shipped recently.                    aligned to the baseline.
//
// The rule draws in from the left and the title rises line by line.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import 'split_lines.dart';

class SectionHeader extends StatelessComponent {
  const SectionHeader({
    required this.index,
    required this.label,
    required this.title,
    this.lede,
    super.key,
  });

  /// Two-digit section number, e.g. '02'.
  final String index;

  /// Short mono label, e.g. 'Selected work'.
  final String label;

  /// Title lines (with `_accent_` markup).
  final List<String> title;

  final String? lede;

  @override
  Component build(BuildContext context) {
    return div(classes: 'shead', [
      div(classes: 'shead__meta', [
        span(classes: 'label shead__index', [Component.text('($index)')]),
        span(classes: 'label shead__label', [Component.text(label)]),
        span(
          classes: 'shead__rule',
          attributes: const {'data-reveal': 'line', 'aria-hidden': 'true'},
          [],
        ),
      ]),
      div(classes: 'shead__body', [
        SplitLines(title, tag: SplitTag.h2, classes: 'shead__title'),
        if (lede != null)
          p(
            classes: 'shead__lede',
            attributes: const {'data-reveal': '', 'style': '--d: 250ms'},
            [Component.text(lede!)],
          ),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.shead').styles(raw: {'margin-bottom': 'clamp(3rem, 7vw, 6rem)'}),
    css('.shead__meta').styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'gap': '1rem',
      'margin-bottom': 'clamp(1.5rem, 3vw, 2.75rem)',
    }),
    css('.shead__index').styles(raw: {'color': 'var(--text)'}),
    css('.shead__rule').styles(raw: {
      'flex': '1',
      'height': '1px',
      'background': 'var(--line-strong)',
    }),
    css('.shead__body').styles(raw: {
      'display': 'grid',
      'gap': '1.5rem',
    }),
    css('.shead__title').styles(raw: {
      'font-size': 'var(--fs-h2)',
      'line-height': '0.94',
      'letter-spacing': '-0.048em',
    }),
    css('.shead__lede').styles(raw: {
      'font-size': 'var(--fs-body-lg)',
      'max-width': '34ch',
    }),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.shead__body').styles(raw: {
        'grid-template-columns': 'minmax(0, 1fr) minmax(0, 32ch)',
        'align-items': 'end',
        'gap': '4rem',
      }),
      css('.shead__lede').styles(raw: {'padding-bottom': '0.6rem'}),
    ]),
  ];
}

// Large paragraph whose words light up one by one as you scroll.
//
// Each word is wrapped in `<span class="w">` server-side; GSAP scrubs their
// opacity from dim to full (animation_scripts.dart → `[data-words]`).
// Without GSAP the paragraph simply renders at full opacity.
//
// `_word_` marks a serif-italic accent word.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class ScrubText extends StatelessComponent {
  const ScrubText(this.text, {this.classes, super.key});

  final String text;
  final String? classes;

  @override
  Component build(BuildContext context) {
    final words = text.split(' ').where((w) => w.isNotEmpty).toList();
    return p(
      classes: classes == null ? 'scrub' : 'scrub $classes',
      attributes: const {'data-words': ''},
      [
        for (final word in words) ...[
          span(
            classes: word.startsWith('_') ? 'w serif' : 'w',
            [Component.text(word.replaceAll('_', ''))],
          ),
          Component.text(' '),
        ],
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.scrub').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': 'var(--fs-lead)',
      'font-weight': '500',
      'line-height': '1.14',
      'letter-spacing': '-0.032em',
      'color': 'var(--text)',
    }),
    css('.scrub .w').styles(raw: {'will-change': 'opacity'}),
    css('.scrub .w.serif').styles(raw: {'font-weight': '400'}),
  ];
}

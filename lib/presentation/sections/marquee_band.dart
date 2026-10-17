// Infinite tech-stack marquee between the hero and About.
//
// Two rows drift in opposite directions (CSS keyframes, so it runs even
// without JS). With Lenis + GSAP loaded, the band also skews with scroll
// velocity (`--skew` set on `[data-marquee]`) and springs back when idle.
//
// Decorative (aria-hidden) — the same words appear as real text in Skills.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/ui_icons.dart';
import '../../data/skills_data.dart';

class MarqueeBand extends StatelessComponent {
  const MarqueeBand({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'marquee',
      attributes: const {'data-marquee': '', 'aria-hidden': 'true'},
      [
        _row(marqueeWords, reverse: false),
        _row(marqueeWords.reversed.toList(), reverse: true),
      ],
    );
  }

  static Component _row(List<String> words, {required bool reverse}) {
    // The track holds the list twice so translating it by -50% loops
    // seamlessly.
    final items = [
      for (var copy = 0; copy < 2; copy++)
        for (final w in words)
          span(classes: 'marquee__item', [
            Component.text(w),
            span(classes: 'marquee__star', [RawText(UiIcons.sparkle)]),
          ]),
    ];
    return div(
      classes: reverse ? 'marquee__row marquee__row--reverse' : 'marquee__row',
      [div(classes: 'marquee__track', items)],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.marquee').styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'flex-direction': 'column',
      'gap': 'clamp(0.25rem, 1vw, 0.75rem)',
      'padding-block': 'clamp(2.5rem, 6vw, 5rem)',
      'border-block': '1px solid var(--line)',
      'overflow': 'hidden',
      'user-select': 'none',
    }),
    css('.marquee__row').styles(raw: {
      'display': 'flex',
      'transform': 'skewX(var(--skew, 0deg))',
    }),
    css('.marquee__track').styles(raw: {
      'display': 'flex',
      'flex-shrink': '0',
      'animation': 'marquee 48s linear infinite',
      'will-change': 'transform',
    }),
    css('.marquee__row--reverse .marquee__track').styles(raw: {
      'animation-direction': 'reverse',
      'animation-duration': '58s',
    }),
    css('.marquee__item').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': 'clamp(1.25rem, 2.6vw, 2.75rem)',
      'padding-right': 'clamp(1.25rem, 2.6vw, 2.75rem)',
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(2.6rem, 7.4vw, 7.25rem)',
      'font-weight': '500',
      'line-height': '1.05',
      'letter-spacing': '-0.045em',
      'white-space': 'nowrap',
      'color': 'var(--text)',
    }),
    css('.marquee__row--reverse .marquee__item').styles(raw: {
      'color': 'transparent',
      '-webkit-text-stroke': '1px var(--line-strong)',
    }),
    css('.marquee__star').styles(raw: {
      'display': 'inline-flex',
      'width': '0.42em',
      'height': '0.42em',
      'color': 'var(--primary)',
      '-webkit-text-stroke': '0',
    }),
    css('.marquee__row--reverse .marquee__star').styles(raw: {'color': 'var(--secondary)'}),
    css('.marquee__star svg').styles(raw: {'width': '100%', 'height': '100%'}),
  ];
}

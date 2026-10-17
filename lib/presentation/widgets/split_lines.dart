// Masked line-by-line text reveal.
//
//   SplitLines(['Products I've', '_shipped_ recently'], tag: SplitTag.h2)
//
// Renders each line as `.line > .line__inner`; the inner span slides up out
// of its mask when the parent gains `.is-in` (see animation_styles.dart).
// Lines are authored explicitly (not measured) so the HTML is static,
// SEO-friendly and identical with or without JavaScript.
//
// `_word_` in a line becomes the serif-italic accent.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/utils/rich_text.dart';

enum SplitTag { h1, h2, h3, p, div, span }

class SplitLines extends StatelessComponent {
  /// Lines from plain strings (with `_accent_` markup).
  const SplitLines(
    this.lines, {
    this.tag = SplitTag.h2,
    this.classes,
    this.onLoad = false,
    this.delayMs = 0,
    this.ariaHidden = false,
    super.key,
  }) : custom = null;

  /// Lines from arbitrary components (e.g. a line containing a rotator).
  const SplitLines.custom(
    List<List<Component>> this.custom, {
    this.tag = SplitTag.h2,
    this.classes,
    this.onLoad = false,
    this.delayMs = 0,
    this.ariaHidden = false,
    super.key,
  }) : lines = const [];

  final List<String> lines;
  final List<List<Component>>? custom;
  final SplitTag tag;
  final String? classes;

  /// Play when the preloader finishes instead of on scroll.
  final bool onLoad;

  /// Extra delay before the first line starts.
  final int delayMs;

  /// Hide from assistive tech (when an sr-only copy carries the text).
  final bool ariaHidden;

  @override
  Component build(BuildContext context) {
    final content = custom ?? [for (final l in lines) richText(l)];
    final children = <Component>[
      for (var i = 0; i < content.length; i++)
        span(classes: 'line', [
          span(
            classes: 'line__inner',
            attributes: {'style': '--i: $i'},
            content[i],
          ),
        ]),
    ];
    final attrs = <String, String>{
      'data-split': '',
      if (onLoad) 'data-load': '',
      if (delayMs > 0) 'style': '--d: ${delayMs}ms',
      if (ariaHidden) 'aria-hidden': 'true',
    };

    return switch (tag) {
      SplitTag.h1 => h1(classes: classes, attributes: attrs, children),
      SplitTag.h2 => h2(classes: classes, attributes: attrs, children),
      SplitTag.h3 => h3(classes: classes, attributes: attrs, children),
      SplitTag.p => p(classes: classes, attributes: attrs, children),
      SplitTag.div => div(classes: classes, attributes: attrs, children),
      SplitTag.span => span(classes: classes, attributes: attrs, children),
    };
  }
}

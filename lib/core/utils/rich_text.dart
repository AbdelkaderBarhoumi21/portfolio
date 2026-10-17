// Tiny inline-markup helpers for copy coming from `lib/data/`.
//
//   richText('Products I _shipped_')  →  [text, <em class="serif">, …]
//
// `_word_` marks the serif-italic accent. Kept deliberately minimal — this is
// a portfolio, not a Markdown engine.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Parses `_accent_` segments into serif `<em>` nodes.
List<Component> richText(String source) {
  final parts = source.split('_');
  return [
    for (var i = 0; i < parts.length; i++)
      if (parts[i].isNotEmpty)
        i.isOdd
            ? em(classes: 'serif', [Component.text(parts[i])])
            : Component.text(parts[i]),
  ];
}

/// Removes `_accent_` markers, for aria-labels and plain-text contexts.
String plainText(String source) => source.replaceAll('_', '');

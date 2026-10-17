---
name: jaspr-component
description: Scaffold a new Jaspr StatelessComponent (section, card, widget, button) following this project's clean-architecture conventions, CSS-custom-property theming and data-attribute motion hooks. Use whenever the user asks to "create a section / card / widget / button" in Dart with Jaspr.
---

# Skill — Scaffold a Jaspr component

## When to use

Any request like "make a `TestimonialCard` widget", "add a `PressRow`",
"create a talks section component", etc.

## Decision tree

1. **Does it need browser-side behavior** (toggle, pointer, timer, scroll)?
   - Still a `StatelessComponent`. There are **no** `@client` components in
     this repo: add a `data-*` hook and handle it in the vanilla-JS engine
     (`lib/core/animations/animation_scripts.dart`) — see the
     `jaspr-animation` skill. Existing hooks: `data-reveal`, `data-split`,
     `data-count`, `data-rotator`, `data-clock`, `data-copy`,
     `data-spotlight`, `data-cursor`, `.magnetic`, …
2. **Where does it live?**
   - Reusable, content-agnostic   → `lib/presentation/widgets/`
   - Top-level scroll section     → `lib/presentation/sections/`
     (also: `AppAnchors` id + `AppAnchors.items` entry or `data-spy`,
     and insert it in `app.dart`)
   - Layout chrome (nav, footer)  → `lib/presentation/layout/`
3. **Does it need new design tokens** (color, spacing, font size)?
   - Yes → add to `lib/core/theme/app_*.dart` **and** emit the CSS var in
     `global_styles.dart` first.
4. **Does it need new content**?
   - Yes → add to the right `lib/data/*.dart` file (model in
     `lib/domain/models/` if structured). Never hardcode copy.

Reuse before creating: `SectionHeader`, `SplitLines`, `ScrubText`,
`PillButton` (`PillVariant.solid` / `.ghost`), `TechChip`, `StatCounter`,
`SocialIcon`, `LocalClock`, `PhoneMockup`.

## Template — StatelessComponent

```dart
// One-line purpose + a small ASCII sketch of the layout if useful.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../domain/models/stat.dart';

class StatTile extends StatelessComponent {
  const StatTile({required this.stat, this.delayMs = 0, super.key});

  final Stat stat;
  final int delayMs;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'stat-tile',
      attributes: {'data-reveal': '', 'style': '--d: ${delayMs}ms'},
      [
        span(classes: 'label', [Component.text(stat.label)]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.stat-tile').styles(raw: {
      'padding': '1.5rem',
      'background': 'var(--surface)',
      'border': '1px solid var(--line)',
      'border-radius': 'var(--radius-md)',
      'transition': 'border-color 0.5s var(--ease-out)',
    }),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.stat-tile').styles(raw: {'padding': '2rem'}),
    ]),
  ];
}
```

Accent copy: pass strings with `_word_` through `richText()`
(`core/utils/rich_text.dart`) or `SplitLines`. Per-item accent colors: set
`data-tone` from the model's `tone` and style with `var(--tone)`.

## Hard rules

- One component per file. File name = `snake_case_of_class.dart`.
- `StatelessComponent` only — no `@client`, no `<script>` strings.
- Use `dom.dart` HTML helpers (`div`, `section`, `button`, `a`, …).
- Colors/fonts/spacing via CSS vars (`var(--text)`, `var(--fs-h2)`,
  `var(--gutter)`) or typed `AppColors.*` refs — **never** literal `#hex`.
  It must still look right inside `.theme-paper`.
- Co-locate styles via `@css static List<StyleRule> get styles`; media
  queries via `minWidth()` / `maxWidth()` with `AppSpacing.bp*`.
- For animations, use the shared hooks (`data-reveal`, `data-split`, …);
  do not write keyframes per component.

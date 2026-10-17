# 02 — Design system

The single source of truth for design tokens lives in `lib/core/theme/`.
Treat the values below as **documentation**; if you want to change them,
edit the Dart file, not this doc.

Direction: **cinematic, editorial, dark** — big display type, serif-italic
accent words, hairline rules, mono labels, film grain.

## How tokens reach the page

1. `app_colors.dart` / `app_typography.dart` / `app_spacing.dart` define the
   values (raw `*Hex` strings, clamps, numbers).
2. `global_styles.dart` emits them **once** as CSS custom properties on
   `:root` (and re-skins on `.theme-paper`).
3. Components read `var(--x)` — usually via
   `css('.x').styles(raw: {'color': 'var(--text)'})`, or the typed refs
   (`AppColors.textPrimary` = `Color('var(--text)')`).

Only `global_styles.dart` reads `AppColors.*Hex`.

## Palette

| CSS var         | Ink (`:root`)            | Paper (`.theme-paper`) | Dart ref                  |
| --------------- | ------------------------ | ---------------------- | ------------------------- |
| `--bg`          | `#09090B`                | `#EEEDE8`              | `AppColors.bg`            |
| `--bg-raised`   | `#111114`                | `#E7E6E0`              | `AppColors.bgRaised`      |
| `--surface`     | `#16161A`                | `#E1E0D9`              | `AppColors.surface`       |
| `--text`        | `#EDEDF0`                | `#0E0E11`              | `AppColors.textPrimary`   |
| `--text-dim`    | `#9C9CA8`                | `#55555E`              | `AppColors.textSecondary` |
| `--text-faint`  | `#5C5C68`                | `#8D8D95`              | `AppColors.textMuted`     |
| `--line`        | `rgba(255,255,255,0.08)` | `rgba(14,14,17,0.12)`  | `AppColors.line`          |
| `--line-strong` | `rgba(255,255,255,0.16)` | `rgba(14,14,17,0.26)`  | `AppColors.lineStrong`    |
| `--primary`     | `#6C63FF` violet         | `#5148E8`              | `AppColors.primary`       |
| `--secondary`   | `#00D9FF` cyan           | —                      | `AppColors.secondary`     |
| `--tone`        | `#6C63FF` (default)      | —                      | `AppColors.tone`          |

Also on `:root`: `--glass`, `--brand-gradient`
(`linear-gradient(120deg, #6C63FF, #00D9FF)` — logo, progress bar),
`--success` (emerald, status dot).

### Paper sections

Add `theme-paper` to any element and it plus all its children recolor
through the cascade — no extra CSS. Used on `ExperienceSection`.

```dart
section(id: AppAnchors.experience, classes: 'section experience theme-paper', [...])
```

There is no light/dark toggle: the site is dark, with paper panels for rhythm.

### Accent tones

`AppColors.tones` maps `violet | cyan | amber | emerald | rose` to hex.
`global_styles.dart` emits `[data-tone="amber"] { --tone: #FFB547 }` etc.,
so data picks an accent with a plain string (`FeaturedProject.tone`,
`Project.tone`) and the widget sets `data-tone` and styles with `var(--tone)`.

## Typography

| Role              | Family                    | Dart token                  | CSS var          |
| ----------------- | ------------------------- | --------------------------- | ---------------- |
| Display headings  | Inter Tight               | `AppTypography.fontDisplay` | `--font-display` |
| Accent words      | Instrument Serif *italic* | `AppTypography.fontSerif`   | `--font-serif`   |
| Body              | Inter                     | `AppTypography.fontBody`    | `--font-body`    |
| Labels / metadata | JetBrains Mono            | `AppTypography.fontMono`    | `--font-mono`    |

Loaded via `<link>` in `main.server.dart` from `AppTypography.googleFontsUrl`.

| CSS var        | Dart token                   | Value                            |
| -------------- | ---------------------------- | -------------------------------- |
| `--fs-display` | `AppTypography.displayClamp` | `clamp(3.4rem, 14.6vw, 15.5rem)` |
| `--fs-h2`      | `AppTypography.h2Clamp`      | `clamp(2.6rem, 7.2vw, 7rem)`     |
| `--fs-h3`      | `AppTypography.h3Clamp`      | `clamp(1.7rem, 3.2vw, 3rem)`     |
| `--fs-lead`    | `AppTypography.leadClamp`    | `clamp(1.55rem, 3.6vw, 3.4rem)`  |
| `--fs-body-lg` | `AppTypography.bodyLgClamp`  | `clamp(1.05rem, 1.25vw, 1.2rem)` |
| `--fs-small`   | `AppTypography.smallSize`    | `0.875rem`                       |
| `--fs-label`   | `AppTypography.labelSize`    | `0.72rem`                        |

Utility classes: `.serif` (accent italic), `.label` (mono, uppercase,
`0.14em` tracking, dim), `.mono`.

**Accent markup:** in data and heading strings, `_word_` renders as
`<em class="serif">word</em>` — `richText()` in `core/utils/rich_text.dart`
(also used by `SplitLines`; `ScrubText` handles it per word).
`plainText()` strips the markers for aria-labels.

## Spacing & layout

| Token                     | Value                                | CSS var       |
| ------------------------- | ------------------------------------ | ------------- |
| `AppSpacing.xs … xxl`     | `0.25 / 0.5 / 1 / 1.5 / 2.5 / 4` rem | —             |
| `AppSpacing.gutter`       | `clamp(1.25rem, 4vw, 3.5rem)`        | `--gutter`    |
| `AppSpacing.sectionY`     | `clamp(6rem, 14vh, 11rem)`           | `--section-y` |
| `AppSpacing.container`    | `1440` px                            | `--container` |
| `AppSpacing.navbarHeight` | `76` px                              | `--nav-h`     |

Layout primitives: `.container` (max-width + gutter), `.section`
(`padding-block: var(--section-y)`), `.sr-only`.

## Radii

`--radius-sm` 10px · `--radius-md` 18px · `--radius-lg` 28px ·
`--radius-xl` 44px (`AppSpacing.radiusSm … radiusXl`; `radiusFull` = 999).

## Breakpoints (mobile-first)

| Token             | px   |
| ----------------- | ---- |
| `AppSpacing.bpSm` | 560  |
| `AppSpacing.bpMd` | 768  |
| `AppSpacing.bpLg` | 1024 |
| `AppSpacing.bpXl` | 1280 |

Use the helpers from `global_styles.dart`:

```dart
css.media(minWidth(AppSpacing.bpLg), [ ... ]),   // (min-width: 1024px)
css.media(maxWidth(AppSpacing.bpMd), [ ... ]),   // (max-width: 767px)
```

## Motion tokens

`--ease-out` `cubic-bezier(0.22, 1, 0.36, 1)` · `--ease-expo`
`cubic-bezier(0.16, 1, 0.3, 1)` · `--ease-in-out`
`cubic-bezier(0.76, 0, 0.24, 1)`. See `03-animations.md`.

## Component style recipe

```dart
@css
static List<StyleRule> get styles => [
  css('.my-card').styles(raw: {
    'background': 'var(--surface)',
    'border': '1px solid var(--line)',
    'border-radius': 'var(--radius-lg)',
    'transition': 'transform 0.6s var(--ease-out)',
  }),
  css.media(minWidth(AppSpacing.bpLg), [ ... ]),
];
```

> All of the above is rendered through the Jaspr `StyleRule` API —
> see `docs/04-jaspr-cheatsheet.md`.

# CLAUDE.md — Project Memory

This file gives Claude Code persistent context for this repository.
Read it before making changes.

## Project

**Name:** `protfolio_website`
**Purpose:** Personal developer portfolio for **Barhoumi Abdelkader**
(Mobile Lead @ Oxton Digital — Flutter & Android, Tunis, Tunisia).
**Framework:** [Jaspr](https://jaspr.site) `^0.23.1` — modern Dart web framework.
**Render mode:** **Static (SSG)** — `jaspr.mode: static` in `pubspec.yaml`.
**Routing:** Single long-scroll page with anchor links (`#home`, `#about`, `#work`, …).
No multi-page navigation; `jaspr_router` is present but used minimally.

## Owner profile (used in copy)

- **Name:** Barhoumi Abdelkader
- **Role:** Mobile Lead @ Oxton Digital — Mobile Software Engineer (Flutter & Android)
- **Email:** abdelkaderbarhoumi21@gmail.com
- **Phone:** +216 20 778 960
- **LinkedIn:** linkedin.com/in/barhoumi23176
- **GitHub:** github.com/AbdelkaderBarhoumi21
- **Languages:** Arabic (native), English B2, French B2

Full data lives in `lib/data/` — never hardcode profile facts inside section files.

## Architecture

Adapted Flutter Clean Architecture for a static site:

```
lib/
├── core/           ← theme, animations, constants, utils (cross-cutting)
├── data/           ← static content (profile, featured work, projects, experience, skills, education)
├── domain/models/  ← typed entities (Experience, FeaturedProject, Project, Stat, …)
└── presentation/
    ├── layout/     ← AppLayout, Navbar, MobileMenu, Preloader, Footer
    ├── sections/   ← HeroSection, AboutSection, WorkSection, … (one per scroll anchor)
    └── widgets/    ← reusable: SplitLines, SectionHeader, PillButton, WorkCard, …
```

Page order (`lib/app.dart`): Hero `#home` → MarqueeBand (decorative, no anchor)
→ About `#about` → Work `#work` → Lab `#lab` (`data-spy="work"`) → Experience
`#experience` (`.theme-paper`) → Skills `#skills` → Education `#education` →
Contact `#contact`.

**Rules:**
1. One component per file. No "kitchen sink" files.
2. `presentation/widgets/` must be reusable and content-agnostic
   (no hardcoded text from `data/`).
3. `presentation/sections/` consume `data/` and compose `widgets/`.
4. `domain/models/` are pure Dart — no `jaspr` imports.
5. Theme tokens (`core/theme/`) are the **only** source for colors, spacing,
   typography. Sections/widgets must reference them, not literal hex codes.

## Theme philosophy (Flutter-style)

Like Flutter's `Theme.of(context)`, we define design tokens **once** in
`core/theme/` (`app_colors.dart`, `app_typography.dart`, `app_spacing.dart`,
barrel `app_theme.dart`). `global_styles.dart` emits them as CSS custom
properties on `:root`; components read `var(--x)`, so nothing is prop-drilled.

- `AppColors.*Hex` — raw palette, read **only** by `global_styles.dart`.
- `AppColors.bg`, `.textPrimary`, `.primary`, `.tone`, … — typed `Color('var(--x)')` refs.
- `AppTypography.displayClamp`, `.fontSerif`, `.googleFontsUrl`, …
- `AppSpacing.gutter`, `.sectionY`, `.radiusMd`, `.bpLg`, …
- Components mostly write `css('.x').styles(raw: {'color': 'var(--text)', …})`.
  Media queries use `minWidth(px)` / `maxWidth(px)` from `global_styles.dart`.

## Design system (summary — see `docs/02-design-system.md`)

- **Direction:** cinematic, editorial, dark.
- **Ink (default, `:root`):** bg `#09090B`, text `#EDEDF0`, dim `#9C9CA8`.
- **Paper (light):** add class `theme-paper` to any element (used on
  Experience) — custom properties cascade, children recolor automatically.
- **Accents:** violet `#6C63FF` (`--primary`), cyan `#00D9FF` (`--secondary`);
  per-item accent via `data-tone="violet|cyan|amber|emerald|rose"` → `--tone`
  (`AppColors.tones`).
- **Fonts:** Inter Tight (display), Instrument Serif italic (accent words),
  Inter (body), JetBrains Mono (labels). `_word_` in data/heading strings →
  `<em class="serif">` (`core/utils/rich_text.dart`).
- There is **no** light/dark toggle — one dark site with paper sections.

## Animations (see `docs/03-animations.md`)

- Stack: Lenis 1.3.11 + GSAP 3.13.0 + ScrollTrigger (pinned CDN URLs in
  `core/constants/app_assets.dart`, `defer`-loaded in `main.server.dart`),
  driven by one vanilla-JS engine: `animationScripts` in
  `core/animations/animation_scripts.dart`. `bootstrapScript` (sync, in head)
  adds `html.js is-loading` and a 4.5s `.reveal-all` failsafe.
- Components opt in with data attributes: `[data-reveal]` (variants `fade`,
  `scale`, `clip`, `line`), `[data-split]` (SplitLines), `[data-load]`,
  `[data-words]` (ScrubText), `[data-count]`, `[data-rotator]`, `[data-cursor]`,
  `[data-spotlight]`, `[data-parallax]`, `.magnetic`, …
- GSAP scenes: hero parallax-out, scrubbed statement, stacked work cards,
  pinned horizontal Lab, marquee skew. Everything degrades: no CDN → native
  scroll + visible content; `prefers-reduced-motion` → no motion.
- Easing: `--ease-out` `cubic-bezier(0.22,1,0.36,1)`, `--ease-expo`
  `cubic-bezier(0.16,1,0.3,1)`, `--ease-in-out` `cubic-bezier(0.76,0,0.24,1)`.

## Jaspr conventions used here

- Components are `StatelessComponent` only — there are **no** `@client`
  components; all interactivity is the vanilla JS engine.
- Use `@css` on a `static List<StyleRule> get styles` getter to ship
  CSS bundled with the component.
- Use `dom.dart` HTML primitives (`div`, `section`, `h1`, …) — not Flutter
  widgets.
- Anchor scrolling: each section is a `<section id="...">`; the navbar uses
  plain `<a href="#...">` links (labels from `AppAnchors.items`) and the
  engine glides to them via `lenis.scrollTo`.

## Commands

```bash
# dev server (hot reload)
jaspr serve

# static build → build/jaspr/
jaspr build
```

The jaspr CLI 0.23.5 needs `build_daemon >= 4.1.3` (already bumped in
`pubspec.lock`).

## What NOT to do

- ❌ Do not embed Flutter Web — this is pure Jaspr.
- ❌ Do not add Tailwind — styling stays in Dart via `StyleRule`.
- ❌ Do not hardcode colors/fonts inside sections — use `core/theme/`.
- ❌ Do not duplicate content between `data/` and section files.
- ❌ Do not invent new sections without updating the navbar and ScrollSpy
  (`AppAnchors.items`, or `data-spy` to borrow an existing link).
- ❌ Do not add `@client` components for things the JS engine already handles.
- ❌ Do not load vendor scripts unpinned or call them without feature
  detection (`window.gsap`, `window.Lenis`).
- ❌ Do not add hidden reveal states outside `.js` — `.js [data-…]` only, so
  the page reads with JS off.

## Where to look first

- New feature?  → `docs/01-architecture.md`
- New color/font?  → `lib/core/theme/`
- New animation?  → `docs/03-animations.md` + `lib/core/animations/`
- Jaspr syntax reminder?  → `docs/04-jaspr-cheatsheet.md`
- Content edit?  → `lib/data/`

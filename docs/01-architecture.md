# 01 — Architecture

This portfolio uses **Jaspr** (Dart web framework) in **static (SSG) mode**
with the folder structure adapted from Flutter's clean architecture.

## Layer overview

```
lib/
├── main.server.dart          ← server entrypoint (renders HTML at build time)
├── main.client.dart          ← client entrypoint (scaffold; no @client components today)
├── app.dart                  ← root <App> component
│
├── core/                     ← cross-cutting, no business knowledge
│   ├── theme/                ← THE theme (single source of design tokens)
│   ├── animations/           ← keyframes/reveal CSS + bootstrap & motion-engine JS
│   ├── constants/            ← anchor IDs, CDN/asset paths, inline SVG icons
│   └── utils/                ← rich_text.dart (`_word_` → serif accent)
│
├── data/                     ← static "repository" — content the site renders
│
├── domain/models/            ← pure typed models (no Jaspr imports)
│
└── presentation/             ← UI layer
    ├── layout/               ← AppLayout, Navbar, MobileMenu, Preloader, Footer
    ├── sections/             ← one component per scroll anchor
    └── widgets/              ← small reusable components
```

## Page composition

`app.dart` hands `AppLayout` the ordered sections:

| Section             | Anchor                         | Data                                         |
| ------------------- | ------------------------------ | -------------------------------------------- |
| `HeroSection`       | `#home`                        | `ProfileData`                                |
| `MarqueeBand`       | — (decorative)                 | `marqueeWords`                               |
| `AboutSection`      | `#about`                       | `ProfileData` (statement, bio, facts, stats) |
| `WorkSection`       | `#work`                        | `featuredWork`                               |
| `LabSection`        | `#lab` (`data-spy="work"`)     | `projects`                                   |
| `ExperienceSection` | `#experience` (`.theme-paper`) | `experiences`                                |
| `SkillsSection`     | `#skills`                      | `skillGroups`, `ProfileData.languages`       |
| `EducationSection`  | `#education`                   | `education`, `certifications`                |
| `ContactSection`    | `#contact`                     | `ProfileData`                                |

`AppLayout` wraps them with `Preloader`, the progress bar, `Navbar`,
`MobileMenu`, `Footer`, the cursor ring/dot and the `.grain` overlay.

Widgets: `SplitLines`, `ScrubText`, `SectionHeader`, `PillButton`
(`PillVariant.solid` / `.ghost`), `TechChip`, `BrandMark`, `SocialIcon`,
`LocalClock`, `StatCounter`, `PhoneMockup` (`mock`: fitness | bowling |
commerce | iot), `WorkCard`, `LabCard`, `ExperienceRow`, `SkillRow`.

## Mapping vs. Flutter clean architecture

| Flutter (mobile)        | This Jaspr site                         |
| ----------------------- | --------------------------------------- |
| `core/theme/` ThemeData | `core/theme/app_theme.dart` (+ tokens)  |
| `data/repositories/`    | `data/*.dart` (static lists)            |
| `domain/entities/`      | `domain/models/`                        |
| `presentation/screens/` | `presentation/sections/`                |
| `presentation/widgets/` | `presentation/widgets/`                 |
| `main.dart`             | `main.server.dart` + `main.client.dart` |

## Data flow

```
data/*.dart ──→ domain/models/* ──→ presentation/sections/* ──→ widgets/*
                                          ▲
                          core/theme + core/animations
```

- Sections **never** hardcode profile content. They import from `data/`.
- Widgets **never** import from `data/`. They take typed `domain/models/`
  via constructor parameters — exactly like a Flutter `Widget`.
- `core/theme/*` is imported anywhere it's needed, but the values are
  defined in exactly **one** place per concern (colors, typography, spacing).

## File-naming convention

| Kind            | Pattern                                |
| --------------- | -------------------------------------- |
| Class           | `PascalCase`                           |
| File            | `snake_case_of_the_class.dart`         |
| Section         | `*_section.dart` (`hero_section.dart`) |
| Reusable widget | descriptive noun (`work_card.dart`)    |
| Model           | singular noun (`project.dart`)         |
| Data list       | `*_data.dart` (`projects_data.dart`)   |

## Adding a new section — checklist

1. Add a typed model in `domain/models/` if the section needs structured
   data.
2. Add the data list in `data/`.
3. Create the section file in `presentation/sections/`, importing the data
   and composing widgets.
4. Register the section in `app.dart` (insert it into the scroll order).
5. Add the anchor constant to `core/constants/app_anchors.dart` and, if it
   needs a nav link, to `AppAnchors.items` (Navbar + MobileMenu render that
   list; ScrollSpy watches every `main section[id]`). A sub-section can
   borrow an existing link with `data-spy="<id>"` instead (see `LabSection`).

## Static mode notes

- `jaspr build` outputs plain HTML/CSS/JS to `build/jaspr/`.
- Every component is a `StatelessComponent` rendered at build time — there
  are no `@client` components. Interactivity comes from the vanilla-JS
  engine (`core/animations/animation_scripts.dart`) hooking `data-*`
  attributes, plus Lenis/GSAP from pinned CDNs (see `03-animations.md`).
- Great SEO and fast first paint: all copy is in the static HTML, and the
  page stays readable with JS or the CDNs unavailable.

# Portfolio — Barhoumi Abdelkader

Personal developer portfolio built with [Jaspr](https://jaspr.site) (Dart
web framework) in **static (SSG)** mode. A cinematic, editorial, dark
single-page site: preloader curtain, smooth scroll, masked line reveals,
stacked sticky work cards, a pinned horizontal "Lab" strip, and a custom
cursor.

## Stack

- **Jaspr** `^0.23.1` — static rendering
- **Pure Dart** for everything (no Tailwind, no Flutter Web embedding)
- CSS via Jaspr `StyleRule` (`@css` getters), reading CSS custom properties
- Motion: [Lenis](https://github.com/darkroomengineering/lenis) 1.3.11 +
  [GSAP](https://gsap.com) 3.13.0 / ScrollTrigger from pinned CDN URLs, driven
  by one vanilla-JS engine injected via `Document(head: [script(...)])`.
  Feature-detected: with the CDN blocked or reduced motion on, the page is
  still fully readable.

## Run

```bash
# dev server with hot reload — http://localhost:8080
jaspr serve

# static build — outputs to build/jaspr/
jaspr build
```

The jaspr CLI 0.23.5 needs `build_daemon >= 4.1.3` (already pinned in
`pubspec.lock`).

### Production build with sitemap

When deploying, pass your real domain so Jaspr generates `sitemap.xml`:

```bash
jaspr build --sitemap-domain https://abdelkaderbarhoumi.dev
```

Also remember to:

- Keep `web/cv/Mobile_Abdelkader_Barhoumi_CV.pdf` current (Download CV button).
- Drop `web/images/og-card.png` (1200×630) for social link previews.

### Deploy to GitHub Pages

The repo ships a workflow at `.github/workflows/deploy.yml` that builds
the site and publishes it to GitHub Pages on every push to `main`.

**One-time setup** (do this once in the GitHub UI):

1. Repo → **Settings → Pages → Source: "GitHub Actions"** (not "Deploy from a branch").
2. Push the workflow file to `main` (the first push to `main` after that triggers a deploy).

After ~2 minutes, the site is live at:

> <https://abdelkaderbarhoumi21.github.io/portfolio/>

**How the subpath works.** GitHub Pages hosts project sites under
`/<repo-name>/`, so `index.html` and every asset must use that as a base.
The workflow passes `BASE_HREF=/portfolio/` to the build via
`--dart-define-server`, which `lib/main.server.dart` reads at SSG time
and passes to `Document(base: ...)`. Local `jaspr serve` is unaffected
(no env var → defaults to `/`).

**Custom domain.** If you later buy a domain (e.g. `abdelkaderbarhoumi.dev`):

1. Add a `CNAME` file to `web/` containing the domain.
2. Configure DNS at your registrar.
3. Repo → **Settings → Pages → Custom domain** → enter the domain.
4. Edit `.github/workflows/deploy.yml`: change `BASE_HREF` to `/` and
   `SITE_URL` to your domain.

### After adding, deleting or renaming `@client` components

The site currently has none, but if that changes, regenerate the Jaspr
builder options:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Project layout

```text
lib/
├── core/                       cross-cutting (no UI knowledge)
│   ├── theme/                  AppColors, AppTypography, AppSpacing, global_styles (CSS vars)
│   ├── animations/             keyframes + reveal CSS, bootstrap + motion-engine JS
│   ├── constants/              AppAnchors, AppAssets (CDN URLs), tech_icons (`iconFor`), UiIcons
│   └── utils/                  rich_text (`_word_` → serif accent)
├── data/                       static content from the CV
│   ├── profile_data.dart
│   ├── featured_work_data.dart client apps (Work)
│   ├── projects_data.dart      personal projects (Lab)
│   ├── experience_data.dart
│   ├── skills_data.dart
│   └── education_data.dart
├── domain/models/              pure-Dart entities (Experience, FeaturedProject, …)
└── presentation/
    ├── layout/                 AppLayout, Navbar, MobileMenu, Preloader, Footer
    ├── sections/               Hero, MarqueeBand, About, Work, Lab, Experience,
    │                           Skills, Education, Contact
    └── widgets/                reusable: SplitLines, ScrubText, SectionHeader,
                                PillButton, WorkCard, LabCard, PhoneMockup, …
```

Documentation lives in [`docs/`](docs/) — architecture, design system,
animations, Jaspr cheatsheet, and content-data reference. Project memory
for Claude Code is in [`CLAUDE.md`](CLAUDE.md), and the agent + skill
configuration is in [`.claude/`](.claude/).

## Adding content

- New job → edit `lib/data/experience_data.dart`.
- New client app (Work) → edit `lib/data/featured_work_data.dart`.
- New personal project (Lab) → edit `lib/data/projects_data.dart`.
- New skill / marquee word → edit `lib/data/skills_data.dart`.
- Degree / certification → edit `lib/data/education_data.dart`.
- Profile / contact info → edit `lib/data/profile_data.dart`.

Section files **do not** hardcode personal copy — they iterate the data
files above.

## Theming

All design tokens live in `lib/core/theme/` and are emitted as CSS custom
properties by `global_styles.dart` (dark "ink" palette on `:root`, light
"paper" palette on `.theme-paper`). To re-skin the site, edit
`app_colors.dart` / `app_typography.dart` / `app_spacing.dart`; sections and
widgets read `var(--…)` tokens, so they don't need edits.

## License

Personal portfolio — code is for reference; please don't reuse the
content verbatim.

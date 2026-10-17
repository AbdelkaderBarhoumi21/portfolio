# 05 — Content data

All factual content lives in `lib/data/`; typed models are in
`lib/domain/models/`. This doc lists what each file contains so Claude knows
where to add/edit copy.

**Accent markup:** `_word_` in copy and heading strings renders as the
serif-italic accent (`core/utils/rich_text.dart`).

## `lib/data/profile_data.dart` — `ProfileData`

| Group    | Fields                                                                                                                                                   |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Identity | `name`, `firstName`, `lastName`, `initials`, `role`, `subRole`, `location`, `timeZone` (`Africa/Tunis`), `timeZoneLabel`                                 |
| Hero     | `heroRoles` (rotator words), `heroIntro`, `status`                                                                                                       |
| About    | `statement` (scroll-scrubbed), `bio` (paragraphs), `facts` (label/value records, e.g. Currently → "Mobile Lead @ Oxton Digital"), `stats` (`List<Stat>`) |
| Contact  | `availability`, `email`, `phone`, `linkedin`, `github`, `linkedinHandle`, `githubHandle`, `mailto`, `telHref`, `cvPath`                                  |
| Other    | `languages`, `socials` (`List<SocialLink>`, inline SVG icons)                                                                                            |

## `lib/data/featured_work_data.dart` — `featuredWork` (Work section)

`List<FeaturedProject>` — client products as stacked case-study cards.
Fields: `name`, `client`, `year`, `category`, `platforms`, `summary`,
`highlights`, `stack`, `tone` (key of `AppColors.tones`), `mock`
(`PhoneMockup` screen: `fitness | bowling | commerce | iot`), optional `url`.

1. **Sparta Coaching** — Oxton Digital — `violet` / `fitness`
2. **Fun Bowling** — Oxton Digital × Digi Service — `amber` / `bowling`
3. **Masdary** — Stoneslane · Dubai — `cyan` / `commerce`
4. **Wergo** — Sifartek · Algiers — `emerald` / `iot`

## `lib/data/projects_data.dart` — `projects` (Lab section)

`List<Project>` — personal projects in the horizontal Lab strip.
Fields: `title`, `year`, `description`, `highlights`, `tags`, `tone`,
optional `repoUrl` / `demoUrl` (null → link hidden).

1. **Multi-role Commerce Platform** (2025) — Flutter + Laravel, Qt/QML dashboard
2. **Real-time Chat** (2025) — Flutter + Rust (Axum) + WebSockets + MongoDB
3. **Smart Irrigation & Plant Shop** (2024) — Flutter + Gemini API + Firebase

## `lib/data/experience_data.dart` — `experiences`

`List<Experience>` — current roles first, then reverse chronological.
Fields: `company`, `role`, `location`, `employment`, `period`, `current`
(shows the "Now" marker), `bullets`, `tech`.

1. **Oxton Digital** — Mobile Lead — Tunis — *Apr 2026 — Present*
2. **Stoneslane** — Dubai (remote contract) — *Oct 2025 — Present*
3. **Sifartek** — Algiers (remote contract) — *Feb 2026 — Apr 2026*
4. **Nexits** — Paris (remote contract) — *Oct 2025 — Dec 2025*

## `lib/data/skills_data.dart`

- `skillGroups` (`List<SkillGroup>`, curated order): Mobile — Flutter,
  Android Native, Backend & Real-time, Data & Storage, DevOps & Tooling.
- `marqueeWords` — words for the decorative `MarqueeBand` under the hero.

## `lib/data/education_data.dart`

- `education` (`List<Education>`: `degree`, `field`, `school`, `location`,
  `period`) — Engineering Degree (Polytech International), Master and
  Bachelor (ISET Radès).
- `certifications` (`List<Certification>`: `title`, `issuer`).

## Models (`lib/domain/models/`)

`Experience`, `FeaturedProject`, `Project`, `SkillGroup`, `Education`,
`Certification`, `Stat` (`value`, `suffix`, `label`, `pad` — count-up
number), `SocialLink`. Pure Dart, no Jaspr imports; `tone` / `mock` are
plain strings so models stay presentation-free.

## Editing rules

- Never put strings from the CV directly into a section component.
- Section components import `ProfileData`, `featuredWork`, `projects`,
  `experiences`, `skillGroups`, `marqueeWords`, `education`,
  `certifications` and iterate.
- If a new field is added (e.g. "years experience"), add it to the
  matching model/data class first, then surface it.
- Keep `ProfileData.stats` consistent with the data (e.g. certifications count).

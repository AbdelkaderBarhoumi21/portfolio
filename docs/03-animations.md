# 03 — Animations

Motion is **CSS transitions/keyframes + one vanilla-JS engine**, with
[Lenis](https://github.com/darkroomengineering/lenis) (smooth scroll) and
[GSAP](https://gsap.com) + ScrollTrigger (scrubbed/pinned scenes) as
optional enhancers. Components never ship their own JS — they opt in with
`data-*` attributes and classes.

## Anatomy

- **CSS:** `lib/core/animations/animation_styles.dart` — `@css` getter with
  the keyframes, the reveal system and utilities (`.magnetic`, `.hover-line`).
- **Vendors:** pinned URLs in `lib/core/constants/app_assets.dart`
  (`lenis@1.3.11`, `gsap/3.13.0` + `ScrollTrigger`), loaded with `defer`
  from `main.server.dart`.
- **JS:** `lib/core/animations/animation_scripts.dart` exports two strings,
  both injected via `Document(head: ...)` in `main.server.dart`:
  - `bootstrapScript` — sync, before first paint. Adds `html.js is-loading`
    and arms a 4.5s failsafe that adds `.reveal-all` if the engine never
    starts.
  - `animationScripts` — the engine. Runs on `DOMContentLoaded` (after the
    deferred vendors), feature-detects `window.Lenis` / `window.gsap`.

## Degradation

| Condition                | Result                                                                                                                                          |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| JS disabled              | No `.js` class → no hidden states; static page, native scroll.                                                                                  |
| CDN blocked / slow       | Engine still runs: reveals, nav, cursor work; native scroll, no GSAP scenes, Lab is a grid. Failsafe `.reveal-all` if nothing starts in 4.5s.   |
| Engine throws            | Caught → `.reveal-all`, `is-loading` removed.                                                                                                   |
| `prefers-reduced-motion` | No preloader, Lenis, cursor, magnetic, rotator or scenes; reveals show instantly; `global_styles.dart` zeroes all durations and hides `.grain`. |

**Rule:** every hidden "from" state is gated under `.js` (`.js [data-reveal]`).

## Preloader

`Preloader` (`[data-preloader]`, `[data-preloader-count]`,
`[data-preloader-bar]`) counts 0→100 then wipes up (`.is-done`). Shorter on
repeat visits in the same tab (`sessionStorage`). When it ends the engine
removes `is-loading`, starts Lenis and adds `.is-in` to every `[data-load]`
element. A CSS `preloader-failsafe` animation lifts it regardless.

## The reveal pattern

The engine's IntersectionObserver adds `.is-in` once per element.

| Markup                  | Effect                                                                              |
| ----------------------- | ----------------------------------------------------------------------------------- |
| `data-reveal` (default) | opacity 0 → 1, `translateY(44px)` → 0                                               |
| `data-reveal="fade"`    | opacity only                                                                        |
| `data-reveal="scale"`   | `scale(0.94)` + 30px rise                                                           |
| `data-reveal="clip"`    | `clip-path: inset(100% 0 0 0)` wipe up                                              |
| `data-reveal="line"`    | hairline `scaleX(0)` → 1 from the left                                              |
| `data-split`            | masked line reveal (`.line > .line__inner` slides up) — use the `SplitLines` widget |
| `+ data-load`           | plays when the preloader ends instead of on scroll (hero)                           |

## Stagger / delay

- `--d` — per-element delay, set inline: `'style': '--d: ${i * 80}ms'`.
- `--i` — line index inside `SplitLines` (adds `i × 95ms`); `SplitLines`
  sets it, and `delayMs:` maps to `--d`.

```dart
for (var i = 0; i < items.length; i++)
  div(attributes: {'data-reveal': '', 'style': '--d: ${i * 80}ms'}, [...]),
```

## Engine features (attribute → behavior)

| Hook                                                            | Behavior                                                                                                                                                     |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `a[href*="#"]` (same page)                                      | Glides via `lenis.scrollTo` (native smooth fallback); closes the menu.                                                                                       |
| `[data-nav]`                                                    | `.is-scrolled` past 24px; `.is-hidden` on scroll-down, back on scroll-up.                                                                                    |
| `[data-progress]`                                               | Scroll progress bar (`scaleX`).                                                                                                                              |
| `[data-nav-link]` / `[data-menu-link]` + `[data-nav-indicator]` | ScrollSpy: `.is-active` on the link for the section at mid-viewport; the indicator pill slides under it. A section can borrow a link with `data-spy="<id>"`. |
| `[data-menu-toggle]` + `[data-menu]`                            | Toggles `html.menu-open`; Esc closes; auto-closes ≥1024px.                                                                                                   |
| `[data-count="5" data-pad="2"]`                                 | Counts up when 60% visible (`StatCounter`).                                                                                                                  |
| `[data-rotator]` > `.rotator__item`                             | Cycles words every 2.6s (`is-active` / `is-leaving`).                                                                                                        |
| `[data-clock="Africa/Tunis"]`                                   | Live HH:MM for that time zone (`LocalClock`).                                                                                                                |
| `[data-cursor-ring]` / `-dot` / `-label`                        | Custom cursor (fine pointers only, `html.has-cursor`); ring lags at 0.15. `[data-cursor="Label"]` shows a label, links get `.is-link`.                       |
| `.magnetic` (`data-magnetic="0.28"`)                            | Leans toward the pointer.                                                                                                                                    |
| `[data-spotlight]`                                              | Writes `--mx` / `--my` for a pointer glow (cards). `[data-hero]` also gets `--px` / `--py`.                                                                  |
| `[data-copy]` + `[data-copy-label]`                             | Copies to clipboard, shows `data-copied` text for 1.8s.                                                                                                      |

## GSAP scenes (`setupScenes`, only with GSAP and motion on)

| Scene              | Hooks                                                               | Notes                                                                                                                                                                    |
| ------------------ | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Hero pull-back     | `#home`, `[data-hero-inner]`, `[data-hero-bg]`                      | content drifts up + fades, bg zooms                                                                                                                                      |
| Scrubbed statement | `[data-words]` > `.w` (`ScrubText`)                                 | words go 0.13 → 1 opacity                                                                                                                                                |
| Parallax           | `[data-parallax="0.15"]`, trigger `[data-parallax-root]`            |                                                                                                                                                                          |
| Stacked work cards | `[data-stack-item]` > `.wcard` + `[data-shade]`                     | `(min-width: 900px) and (min-height: 800px)`; covered card scales to 0.9 and darkens                                                                                     |
| Horizontal Lab     | `[data-hscroll]`, `[data-hscroll-track]`, `[data-hscroll-progress]` | `(min-width: 1024px) and (min-height: 700px)`; pins and adds `html.has-hscroll` only while active, so the horizontal layout never exists without the code that drives it |
| Marquee skew       | `[data-marquee]` → `--skew`                                         | from Lenis velocity; the marquee itself is a CSS keyframe and runs without JS                                                                                            |

## Keyframes (`animation_styles.dart`)

`grain`, `orb-drift`, `marquee`, `pulse-dot`, `scroll-line`, `rise`,
`spin`, `preloader-failsafe`.

## Easing

| Var             | Curve                            | Use                               |
| --------------- | -------------------------------- | --------------------------------- |
| `--ease-out`    | `cubic-bezier(0.22, 1, 0.36, 1)` | default transitions               |
| `--ease-expo`   | `cubic-bezier(0.16, 1, 0.3, 1)`  | reveals, line masks, button rolls |
| `--ease-in-out` | `cubic-bezier(0.76, 0, 0.24, 1)` | clip wipes, curtains              |

Typewriter and 3D tilt were removed — the hero uses the rotator, cards use
the spotlight.

---
name: jaspr-animation
description: Add a scroll-triggered, hover, or entrance animation to this Jaspr portfolio. Knows how to plug into the project's data-attribute reveal system (IntersectionObserver + `.is-in`), the Lenis + GSAP/ScrollTrigger scene layer, and the shared keyframe library. Use whenever the user asks to "animate", "fade in on scroll", "stagger", "reveal lines", "parallax", "pin", "scrub", "magnetic", "spotlight", or add a cursor / rotator / marquee effect.
---

# Skill — Add an animation

Full reference: `docs/03-animations.md`.

## How animations work here

1. **CSS** for the visual states lives in
   `lib/core/animations/animation_styles.dart` (hidden states under `.js`).
2. **JS** lives in `animationScripts` in
   `lib/core/animations/animation_scripts.dart`, injected via
   `Document(head: ...)` in `main.server.dart` after the deferred Lenis /
   GSAP / ScrollTrigger scripts (pinned in `core/constants/app_assets.dart`).
3. A component **opts in** with a data attribute (e.g. `data-reveal`) and,
   for staggers, an inline `--d: Nms` delay. No component ships its own JS.

## Recipes

### Fade + slide up on scroll
```dart
div(attributes: const {'data-reveal': ''}, [...])
// variants: 'fade', 'scale', 'clip', 'line'
```

### Staggered list
```dart
for (var i = 0; i < items.length; i++)
  div(
    attributes: {'data-reveal': '', 'style': '--d: ${i * 80}ms'},
    [ ... ],
  ),
```

### Masked line reveal (headings)
```dart
SplitLines(["Products I've", '_shipped_ recently'], tag: SplitTag.h2)
// onLoad: true → plays when the preloader ends (hero); delayMs: → --d
```

### Scroll-scrubbed paragraph
```dart
ScrubText(ProfileData.statement)   // words light up via GSAP ([data-words])
```

### Parallax
```dart
div(attributes: const {'data-parallax-root': ''}, [
  div(attributes: const {'data-parallax': '0.08'}, [...]),
])
```

### Hover: magnetic / spotlight / cursor label
```dart
a(classes: 'magnetic', attributes: const {'data-magnetic': '0.22'}, [...])
article(attributes: const {'data-spotlight': ''}, [...]) // CSS reads --mx/--my
a(attributes: const {'data-cursor': 'Say hi'}, [...])
```

### New GSAP scene
Add a block in `setupScenes(lenis)` (runs only when GSAP is loaded and
motion is allowed). Gate by viewport with `mm.add('(min-width: …)', () => { … })`
and return a cleanup. If the layout differs while the scene runs, toggle a
root class from inside it (like `html.has-hscroll`) so the fallback layout
stays the default.

### New non-GSAP behavior
Add `setupX(motion)` and call it from `init()`. Feature-detect anything
optional (`'IntersectionObserver' in window`, `window.Lenis`).

## Hard rules

- ❌ Never write `<script>` strings inside a section/widget file.
- ❌ Never add another JS animation library or an unpinned CDN URL.
- ❌ No `@client` components for motion.
- ✅ Hidden "from" states only as `.js [data-…]`, and cleared by `.reveal-all`.
- ✅ Every animation must honor `prefers-reduced-motion` — the engine skips
  motion when `reduce` is true, and `global_styles.dart` zeroes durations.
- ✅ Easing via `var(--ease-out)` (default), `var(--ease-expo)` (reveals),
  `var(--ease-in-out)` (wipes).
- ✅ Keyframes go in `animation_styles.dart`, not per component.

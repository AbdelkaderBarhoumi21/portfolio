// External script URLs + local asset paths.
//
// Vendor libraries are pinned to exact versions on public CDNs and loaded
// with `defer` from main.server.dart. The motion script feature-detects
// each one, so a blocked CDN only removes the effect, never the content.

abstract final class AppAssets {
  // ----- Vendor scripts -----
  /// Lenis — inertial smooth scrolling.
  static const String lenisJs =
      'https://cdn.jsdelivr.net/npm/lenis@1.3.11/dist/lenis.min.js';
  /// GSAP core + ScrollTrigger — scroll-scrubbed scenes and pinning.
  static const String gsapJs =
      'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/gsap.min.js';
  static const String scrollTriggerJs =
      'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/ScrollTrigger.min.js';

  // ----- Local assets (served from web/) -----
  static const String logoSvg = 'images/logo.svg';
}

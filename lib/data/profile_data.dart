// Single source of truth for personal identity, contact info, and the
// copy blocks the hero / about / contact sections render.
//
// Section files MUST read from `ProfileData.*` instead of hardcoding any
// name/email/url. If something here changes, the whole site updates.
//
// Copy conventions:
//   - `_word_` wraps a word in the serif-italic accent style
//     (parsed by core/utils/rich_text.dart).

import '../domain/models/social_link.dart';
import '../domain/models/stat.dart';

abstract final class ProfileData {
  // ---------- Identity ----------
  static const String name      = 'Barhoumi Abdelkader';
  static const String firstName = 'Abdelkader';
  static const String lastName  = 'Barhoumi';
  static const String initials  = 'AB';
  static const String role      = 'Mobile Software Engineer';
  static const String subRole   = 'Flutter & Android';
  static const String location  = 'Tunis, Tunisia';

  /// IANA zone used by the live local-time clock in the hero + footer.
  static const String timeZone      = 'Africa/Tunis';
  static const String timeZoneLabel = 'GMT+1';

  /// Words that cycle through the rotator in the hero role line.
  static const List<String> heroRoles = [
    'Flutter Developer',
    'Android Engineer',
    'Mobile Architect',
    'IoT Specialist',
  ];

  /// Short intro under the hero name.
  static const String heroIntro =
      'I lead the mobile department at Oxton Digital — shipping Flutter and '
      'native Android apps for clients in France, the UAE, Algeria and Tunisia.';

  /// Status pill in the hero.
  static const String status = 'Available for new projects';

  // ---------- About ----------
  /// Large scroll-scrubbed statement. `_word_` = serif accent.
  static const String statement =
      'I build mobile products that feel _effortless_ — Flutter and native '
      'Android apps with clean architecture, real-time features and '
      'offline-first data, taken from the first commit all the way to the '
      '_stores._';

  static const List<String> bio = [
    "I'm a Mobile Software Engineer based in Tunis, currently leading the "
        'mobile department at Oxton Digital, where I oversee Flutter and native '
        'Android delivery across client projects.',
    'My background is in embedded systems and mechatronics — which is why I '
        'enjoy the hard edges of mobile: BLE and Wi-Fi device links, '
        'offline-first sync, real-time chat and payment flows that simply work.',
  ];

  /// Label / value rows on the About section.
  static const List<({String label, String value})> facts = [
    (label: 'Currently', value: 'Mobile Lead @ Oxton Digital'),
    (label: 'Based in', value: 'Tunis, Tunisia'),
    (label: 'Focus', value: 'Flutter · Android · IoT'),
    (label: 'Languages', value: 'Arabic · English · French'),
  ];

  /// Headline numbers (count-up on scroll).
  static const List<Stat> stats = [
    Stat(value: 5, suffix: '+', label: 'Apps shipped to production'),
    Stat(value: 4, label: 'Countries served'),
    Stat(value: 9, label: 'Certifications completed'),
    Stat(value: 3, label: 'Languages spoken'),
  ];

  // ---------- Availability / contact copy ----------
  static const String availability =
      'Open to mobile engineering roles, freelance builds and IoT projects. '
      'Tell me what you are building — I usually reply within a day.';

  // ---------- Spoken languages ----------
  static const List<String> languages = [
    'Arabic (Native)',
    'English (IELTS B2)',
    'French (DELF B2)',
  ];

  // ---------- Contact ----------
  static const String email    = 'abdelkaderbarhoumi21@gmail.com';
  static const String phone    = '+216 20 778 960';
  static const String linkedin = 'https://www.linkedin.com/in/barhoumi23176';
  static const String github   = 'https://github.com/AbdelkaderBarhoumi21';
  static const String linkedinHandle = 'in/barhoumi23176';
  static const String githubHandle   = 'AbdelkaderBarhoumi21';

  /// `mailto:` href used by the contact CTA.
  static const String mailto = 'mailto:$email';
  /// `tel:` href used by the contact card.
  static const String telHref = 'tel:+21620778960';

  // ---------- CV download (file lives in `web/`) ----------
  static const String cvPath = 'cv/Mobile_Abdelkader_Barhoumi_CV.pdf';

  // ---------- Social links ----------
  // Inline SVGs (Simple Icons / Lucide-style paths) so we render them
  // straight into the DOM and they stay themable via `currentColor`.
  static const List<SocialLink> socials = [
    SocialLink(
      label: 'GitHub',
      url: github,
      iconSvg:
          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" '
          'viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">'
          '<path d="M12 .5C5.65.5.5 5.65.5 12c0 5.08 3.29 9.39 7.86 10.91.58.1.79-.25.79-.56 0-.28-.01-1.02-.02-2-3.2.7-3.88-1.54-3.88-1.54-.52-1.33-1.27-1.68-1.27-1.68-1.04-.71.08-.7.08-.7 1.15.08 1.76 1.18 1.76 1.18 1.02 1.75 2.69 1.24 3.35.95.1-.74.4-1.24.73-1.52-2.55-.29-5.24-1.28-5.24-5.69 0-1.26.45-2.29 1.18-3.1-.12-.29-.51-1.47.11-3.06 0 0 .96-.31 3.16 1.18a10.95 10.95 0 0 1 5.75 0c2.2-1.49 3.16-1.18 3.16-1.18.62 1.59.23 2.77.11 3.06.73.81 1.18 1.84 1.18 3.1 0 4.42-2.69 5.39-5.26 5.68.41.35.78 1.04.78 2.1 0 1.51-.01 2.73-.01 3.1 0 .31.21.67.79.56 4.57-1.52 7.86-5.83 7.86-10.91C23.5 5.65 18.35.5 12 .5z"/>'
          '</svg>',
    ),
    SocialLink(
      label: 'LinkedIn',
      url: linkedin,
      iconSvg:
          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" '
          'viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">'
          '<path d="M20.45 20.45h-3.55v-5.57c0-1.33-.02-3.04-1.85-3.04-1.85 0-2.13 1.45-2.13 2.94v5.67H9.37V9h3.41v1.56h.05c.48-.9 1.64-1.85 3.37-1.85 3.6 0 4.27 2.37 4.27 5.46v6.28zM5.34 7.43a2.06 2.06 0 1 1 0-4.12 2.06 2.06 0 0 1 0 4.12zM7.12 20.45H3.56V9h3.56v11.45zM22.23 0H1.77C.79 0 0 .77 0 1.72v20.56C0 23.23.79 24 1.77 24h20.46c.98 0 1.77-.77 1.77-1.72V1.72C24 .77 23.21 0 22.23 0z"/>'
          '</svg>',
    ),
    SocialLink(
      label: 'Email',
      url: mailto,
      iconSvg:
          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" '
          'viewBox="0 0 24 24" fill="none" stroke="currentColor" '
          'stroke-width="2" stroke-linecap="round" stroke-linejoin="round" '
          'aria-hidden="true">'
          '<rect x="3" y="5" width="18" height="14" rx="2"/>'
          '<path d="m3 7 9 6 9-6"/>'
          '</svg>',
    ),
  ];
}

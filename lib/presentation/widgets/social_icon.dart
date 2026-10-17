// Renders a SocialLink as a round, magnetic icon button. The inline SVG
// uses `currentColor` so it follows the hover color transition.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../domain/models/social_link.dart';

class SocialIcon extends StatelessComponent {
  const SocialIcon({required this.link, super.key});

  final SocialLink link;

  @override
  Component build(BuildContext context) {
    // External links open in a new tab; mailto:/tel: stay in same context.
    final isExternal = link.url.startsWith('http');
    return a(
      href: link.url,
      target: isExternal ? Target.blank : null,
      attributes: {
        if (isExternal) 'rel': 'noopener noreferrer',
        'aria-label': link.label,
        'title': link.label,
        'data-magnetic': '0.35',
      },
      classes: 'social-icon magnetic',
      [span(classes: 'social-icon__icon', [RawText(link.iconSvg)])],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.socials').styles(raw: {
      'display': 'flex',
      'gap': '0.6rem',
    }),
    css('.social-icon').styles(raw: {
      'display': 'inline-grid',
      'place-items': 'center',
      'width': '3rem',
      'height': '3rem',
      'border': '1px solid var(--line-strong)',
      'border-radius': '50%',
      'color': 'var(--text-dim)',
      'transition':
          'color 0.4s var(--ease-out), background 0.4s var(--ease-out), '
          'border-color 0.4s var(--ease-out), transform 0.6s var(--ease-out)',
    }),
    css('.social-icon:hover').styles(raw: {
      'color': 'var(--bg)',
      'background': 'var(--text)',
      'border-color': 'var(--text)',
    }),
    css('.social-icon__icon').styles(raw: {
      'display': 'inline-flex',
      'width': '1.1rem',
      'height': '1.1rem',
    }),
    css('.social-icon svg').styles(raw: {'width': '100%', 'height': '100%'}),
  ];
}

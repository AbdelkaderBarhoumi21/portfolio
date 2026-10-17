// Pill CTA rendered as an `<a>` (anchors, mailto:, downloads, external).
//
//   PillButton(label: 'View work', href: '#work')
//   PillButton(label: 'Download CV', href: cv, variant: PillVariant.ghost,
//              icon: UiIcons.download, download: true)
//
// Hover: a fill wipes up from the bottom while the label rolls to a copy of
// itself — the two spans in `.btn__roll` slide up together. Magnetic via
// the shared `.magnetic` behavior.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/ui_icons.dart';

enum PillVariant { solid, ghost }

class PillButton extends StatelessComponent {
  const PillButton({
    required this.label,
    required this.href,
    this.variant = PillVariant.solid,
    this.icon,
    this.download = false,
    this.external = false,
    this.small = false,
    super.key,
  });

  final String label;
  final String href;
  final PillVariant variant;

  /// Inline SVG string (see UiIcons). Defaults to an arrow.
  final String? icon;
  final bool download;
  final bool external;
  final bool small;

  @override
  Component build(BuildContext context) {
    final cls = StringBuffer('btn btn--${variant.name} magnetic');
    if (small) cls.write(' btn--sm');

    return a(
      href: href,
      target: external ? Target.blank : null,
      classes: cls.toString(),
      attributes: {
        'data-magnetic': '0.22',
        if (download) 'download': '',
        if (external) 'rel': 'noopener noreferrer',
      },
      [
        span(classes: 'btn__roll', [
          span(classes: 'btn__text', [Component.text(label)]),
          span(
            classes: 'btn__text',
            attributes: const {'aria-hidden': 'true'},
            [Component.text(label)],
          ),
        ]),
        span(
          classes: 'btn__icon',
          attributes: const {'aria-hidden': 'true'},
          [RawText(icon ?? UiIcons.arrowRight)],
        ),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.btn').styles(raw: {
      'position': 'relative',
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.85rem',
      'height': '3.4rem',
      'padding': '0 0.5rem 0 1.6rem',
      'border-radius': '999px',
      'font-family': 'var(--font-body)',
      'font-size': '0.95rem',
      'font-weight': '500',
      'line-height': '1',
      'white-space': 'nowrap',
      'overflow': 'hidden',
      'isolation': 'isolate',
      'transition':
          'color 0.5s var(--ease-out), border-color 0.5s var(--ease-out), '
          'transform 0.6s var(--ease-out)',
    }),
    // Fill that wipes up on hover.
    css('.btn::before').styles(raw: {
      'content': '""',
      'position': 'absolute',
      'inset': '0',
      'z-index': '-1',
      'border-radius': 'inherit',
      'transform': 'translate3d(0, 101%, 0)',
      'transition': 'transform 0.6s var(--ease-expo)',
    }),
    css('.btn:hover::before, .btn:focus-visible::before').styles(raw: {
      'transform': 'translate3d(0, 0, 0)',
    }),

    // Label roll.
    css('.btn__roll').styles(raw: {
      'position': 'relative',
      'display': 'inline-flex',
      'flex-direction': 'column',
      'height': '1.1em',
      'overflow': 'hidden',
    }),
    css('.btn__text').styles(raw: {
      'display': 'block',
      'line-height': '1.1',
      'transition': 'transform 0.6s var(--ease-expo)',
    }),
    css('.btn:hover .btn__text, .btn:focus-visible .btn__text').styles(raw: {
      'transform': 'translate3d(0, -100%, 0)',
    }),

    // Round icon chip on the right.
    css('.btn__icon').styles(raw: {
      'display': 'inline-grid',
      'place-items': 'center',
      'width': '2.4rem',
      'height': '2.4rem',
      'border-radius': '50%',
      'font-size': '1.05rem',
      'transition':
          'transform 0.6s var(--ease-expo), background 0.5s var(--ease-out), '
          'color 0.5s var(--ease-out)',
    }),
    css('.btn:hover .btn__icon').styles(raw: {'transform': 'rotate(-45deg)'}),
    css('.btn[download]:hover .btn__icon').styles(raw: {'transform': 'translateY(2px)'}),

    // Solid — light pill, dark text; violet fill on hover.
    css('.btn--solid').styles(raw: {
      'background': 'var(--text)',
      'color': 'var(--bg)',
    }),
    css('.btn--solid::before').styles(raw: {'background': 'var(--primary)'}),
    css('.btn--solid:hover').styles(raw: {'color': '#FFFFFF'}),
    css('.btn--solid .btn__icon').styles(raw: {
      'background': 'var(--bg)',
      'color': 'var(--text)',
    }),
    css('.btn--solid:hover .btn__icon').styles(raw: {
      'background': '#FFFFFF',
      'color': 'var(--primary)',
    }),

    // Ghost — hairline outline; fills with text color on hover.
    css('.btn--ghost').styles(raw: {
      'border': '1px solid var(--line-strong)',
      'color': 'var(--text)',
    }),
    css('.btn--ghost::before').styles(raw: {'background': 'var(--text)'}),
    css('.btn--ghost:hover').styles(raw: {
      'color': 'var(--bg)',
      'border-color': 'var(--text)',
    }),
    css('.btn--ghost .btn__icon').styles(raw: {
      'background': 'var(--line)',
      'color': 'var(--text)',
    }),
    css('.btn--ghost:hover .btn__icon').styles(raw: {
      'background': 'var(--bg)',
      'color': 'var(--text)',
    }),

    // Small (navbar).
    css('.btn--sm').styles(raw: {
      'height': '2.75rem',
      'padding': '0 0.35rem 0 1.15rem',
      'font-size': '0.875rem',
      'gap': '0.6rem',
    }),
    css('.btn--sm .btn__icon').styles(raw: {
      'width': '2.05rem',
      'height': '2.05rem',
      'font-size': '0.95rem',
    }),
  ];
}

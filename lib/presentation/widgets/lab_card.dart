// Personal-project card in the horizontal "Lab" strip.
//
// Top: index + year. A glyph panel with the lead technology's logo inside
// concentric orbit rings. Then title, description, highlights and tags.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/tech_icons.dart';
import '../../core/constants/ui_icons.dart';
import '../../domain/models/project.dart';
import 'tech_chip.dart';

class LabCard extends StatelessComponent {
  const LabCard({required this.project, required this.index, super.key});

  final Project project;
  final int index; // 0-based

  @override
  Component build(BuildContext context) {
    final w = project;
    // Lead logo = first tag with a known icon (Flutter for most projects);
    // the second distinctive tag (backend) orbits it.
    final icons = [
      for (final t in w.tags)
        if (iconFor(t) != null) iconFor(t)!,
    ];
    final link = w.repoUrl ?? w.demoUrl;

    return article(
      classes: 'lab-card',
      attributes: {
        'data-tone': w.tone,
        'data-spotlight': '',
        'data-reveal': '',
        'style': '--d: ${index * 90}ms',
      },
      [
        div(classes: 'lab-card__top label', [
          span([Component.text('P—${(index + 1).toString().padLeft(2, '0')}')]),
          span([Component.text(w.year)]),
        ]),
        div(classes: 'lab-card__glyph', attributes: const {'aria-hidden': 'true'}, [
          span(classes: 'lab-card__orbit lab-card__orbit--1', [
            if (icons.length > 2) span(classes: 'lab-card__sat', [RawText(icons[2])]),
          ]),
          span(classes: 'lab-card__orbit lab-card__orbit--2', [
            if (icons.length > 1) span(classes: 'lab-card__sat', [RawText(icons[1])]),
          ]),
          if (icons.isNotEmpty) span(classes: 'lab-card__icon', [RawText(icons.first)]),
        ]),
        h3(classes: 'lab-card__title', [Component.text(w.title)]),
        p(classes: 'lab-card__desc', [Component.text(w.description)]),
        ul(classes: 'lab-card__hl', [
          for (final h in w.highlights) li([Component.text(h)]),
        ]),
        ul(classes: 'chips lab-card__tags', [
          for (final t in w.tags) TechChip(t),
        ]),
        if (link != null)
          a(
            href: link,
            target: Target.blank,
            classes: 'lab-card__link',
            attributes: const {'rel': 'noopener noreferrer'},
            [
              Component.text('View project'),
              RawText(UiIcons.arrowUpRight),
            ],
          ),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.lab-card').styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '1.1rem',
      'padding': 'clamp(1.4rem, 2.3vw, 2.1rem)',
      'border': '1px solid var(--line)',
      'border-radius': 'var(--radius-lg)',
      'background': 'var(--surface)',
      'overflow': 'hidden',
      'isolation': 'isolate',
      'transition': 'border-color 0.5s var(--ease-out)',
    }),
    css('.lab-card:hover').styles(raw: {
      'border-color': 'color-mix(in srgb, var(--tone) 45%, transparent)',
    }),
    css('.lab-card::before').styles(raw: {
      'content': '""',
      'position': 'absolute',
      'inset': '0',
      'z-index': '-1',
      'background':
          'radial-gradient(420px circle at var(--mx, 50%) var(--my, 0%), '
          'color-mix(in srgb, var(--tone) 14%, transparent), transparent 45%)',
      'opacity': '0',
      'transition': 'opacity 0.5s var(--ease-out)',
    }),
    css('.lab-card:hover::before').styles(raw: {'opacity': '1'}),
    css('.lab-card__top').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
    }),

    // Glyph panel with orbit rings.
    css('.lab-card__glyph').styles(raw: {
      'position': 'relative',
      'display': 'grid',
      'place-items': 'center',
      'height': 'clamp(150px, 22vh, 210px)',
      'border-radius': 'var(--radius-md)',
      'overflow': 'hidden',
      'background':
          'radial-gradient(60% 80% at 50% 50%, '
          'color-mix(in srgb, var(--tone) 24%, transparent), transparent 70%), '
          'var(--bg-raised)',
    }),
    css('.lab-card__icon').styles(raw: {
      'position': 'relative',
      'z-index': '1',
      'width': '3.6rem',
      'height': '3.6rem',
      'color': 'var(--tone)',
      'filter': 'drop-shadow(0 0 24px color-mix(in srgb, var(--tone) 60%, transparent))',
      'transition': 'transform 0.9s var(--ease-expo)',
    }),
    css('.lab-card:hover .lab-card__icon').styles(raw: {'transform': 'scale(1.12)'}),
    css('.lab-card__icon svg, .lab-card__sat svg').styles(raw: {
      'width': '100%',
      'height': '100%',
    }),
    css('.lab-card__orbit').styles(raw: {
      'position': 'absolute',
      'top': '50%',
      'left': '50%',
      'border': '1px dashed var(--line-strong)',
      'border-radius': '50%',
      'animation': 'spin 40s linear infinite',
    }),
    css('.lab-card__orbit--1').styles(raw: {
      'width': '9rem',
      'height': '9rem',
      'margin': '-4.5rem 0 0 -4.5rem',
    }),
    css('.lab-card__orbit--2').styles(raw: {
      'width': '14rem',
      'height': '14rem',
      'margin': '-7rem 0 0 -7rem',
      'animation-duration': '60s',
      'animation-direction': 'reverse',
    }),
    css('.lab-card__sat').styles(raw: {
      'position': 'absolute',
      'top': '50%',
      'left': '-1rem',
      'width': '2rem',
      'height': '2rem',
      'margin-top': '-1rem',
      'padding': '0.45rem',
      'border-radius': '50%',
      'background': 'var(--surface)',
      'border': '1px solid var(--line-strong)',
      'color': 'var(--text)',
    }),

    css('.lab-card__title').styles(raw: {
      'font-size': 'clamp(1.6rem, 2.2vw, 2.15rem)',
      'line-height': '1',
      'letter-spacing': '-0.04em',
      'margin-top': '0.35rem',
    }),
    css('.lab-card__desc').styles(raw: {'font-size': '0.95rem'}),
    css('.lab-card__hl').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.45rem',
    }),
    css('.lab-card__hl li').styles(raw: {
      'display': 'flex',
      'gap': '0.65rem',
      'font-size': '0.875rem',
      'color': 'var(--text)',
    }),
    css('.lab-card__hl li::before').styles(raw: {
      'content': '"+"',
      'font-family': 'var(--font-mono)',
      'color': 'var(--tone)',
    }),
    css('.lab-card__tags').styles(raw: {'margin-top': 'auto', 'padding-top': '0.4rem'}),
    css('.lab-card__link').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4rem',
      'font-size': '0.9rem',
      'color': 'var(--text)',
    }),
  ];
}

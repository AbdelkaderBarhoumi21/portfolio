// Large case-study card for a client product ("Selected work").
//
//   ┌──────────────────────────────┬─────────────────────┐
//   │ 01 / 04   CLIENT       2026  │                     │
//   │ Sparta Coaching              │   ( phone mockup )  │
//   │ [Fitness] [iOS · Android]    │                 01  │
//   │ Summary…                     │                     │
//   │ 01 highlight                 │                     │
//   │ 02 highlight                 │                     │
//   │ chips chips chips            │                     │
//   └──────────────────────────────┴─────────────────────┘
//
// In the work section each card is sticky; GSAP scales it down and fades
// in `[data-shade]` as the next card slides over it.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../domain/models/featured_project.dart';
import 'phone_mockup.dart';
import 'tech_chip.dart';

class WorkCard extends StatelessComponent {
  const WorkCard({
    required this.project,
    required this.index,
    required this.total,
    super.key,
  });

  final FeaturedProject project;
  final int index; // 0-based
  final int total;

  String _two(int n) => n.toString().padLeft(2, '0');

  @override
  Component build(BuildContext context) {
    final w = project;
    return article(
      classes: 'wcard',
      attributes: {'data-tone': w.tone, 'data-spotlight': ''},
      [
        div(classes: 'wcard__info', [
          div(classes: 'wcard__meta label', [
            span([Component.text('${_two(index + 1)} / ${_two(total)}')]),
            span(classes: 'wcard__client', [Component.text(w.client)]),
            span([Component.text(w.year)]),
          ]),
          h3(classes: 'wcard__title', [Component.text(w.name)]),
          div(classes: 'wcard__tags', [
            span(classes: 'wcard__tag', [
              span(classes: 'wcard__dot', []),
              Component.text(w.category),
            ]),
            span(classes: 'wcard__tag', [Component.text(w.platforms)]),
          ]),
          p(classes: 'wcard__summary', [Component.text(w.summary)]),
          ol(classes: 'wcard__hl', [
            for (var i = 0; i < w.highlights.length; i++)
              li([
                span(classes: 'wcard__hl-idx', [Component.text(_two(i + 1))]),
                span([Component.text(w.highlights[i])]),
              ]),
          ]),
          ul(classes: 'chips wcard__stack', [
            for (final t in w.stack) TechChip(t, withIcon: true),
          ]),
        ]),
        div(classes: 'wcard__visual', attributes: const {'data-parallax-root': ''}, [
          span(
            classes: 'wcard__num',
            attributes: const {'aria-hidden': 'true'},
            [Component.text(_two(index + 1))],
          ),
          div(classes: 'wcard__phone', attributes: const {'data-parallax': '0.08'}, [
            _visual(w),
          ]),
          span(classes: 'wcard__float', [
            span(classes: 'wcard__dot', []),
            Component.text(w.platforms),
          ]),
        ]),
        div(classes: 'wcard__shade', attributes: const {'data-shade': ''}, []),
      ],
    );
  }

  /// Real screenshot in a phone, a tilted poster for store art, or the
  /// drawn mock when no screenshot exists.
  Component _visual(FeaturedProject w) {
    final shot = w.screenshot;
    final alt = '${w.name} app screen';
    if (shot == null) {
      return PhoneMockup(title: w.name, eyebrow: w.category, mock: w.mock);
    }
    if (shot.framed) {
      return PhoneMockup(
        title: w.name,
        eyebrow: w.category,
        mock: w.mock,
        imageSrc: shot.path,
        imageAlt: alt,
      );
    }
    return div(
      classes: 'wcard__poster',
      attributes: {'style': 'aspect-ratio: ${shot.width} / ${shot.height}'},
      [
        img(
          src: shot.path,
          alt: alt,
          width: shot.width,
          height: shot.height,
          loading: MediaLoading.lazy,
          attributes: const {'decoding': 'async'},
        ),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.wcard').styles(raw: {
      'position': 'relative',
      'display': 'grid',
      'grid-template-columns': 'minmax(0, 1fr)',
      'overflow': 'hidden',
      'isolation': 'isolate',
      'border': '1px solid var(--line)',
      'border-radius': 'var(--radius-xl)',
      'background':
          'radial-gradient(120% 80% at 100% 0%, '
          'color-mix(in srgb, var(--tone) 14%, transparent), transparent 55%), '
          'var(--surface)',
      'transform-origin': '50% 0%',
      'will-change': 'transform',
    }),
    // Pointer spotlight.
    css('.wcard::before').styles(raw: {
      'content': '""',
      'position': 'absolute',
      'inset': '0',
      'z-index': '-1',
      'background':
          'radial-gradient(520px circle at var(--mx, 30%) var(--my, 30%), '
          'color-mix(in srgb, var(--tone) 13%, transparent), transparent 45%)',
      'opacity': '0',
      'transition': 'opacity 0.5s var(--ease-out)',
    }),
    css('.wcard:hover::before').styles(raw: {'opacity': '1'}),
    css('.wcard__shade').styles(raw: {
      'position': 'absolute',
      'inset': '0',
      'z-index': '5',
      'background': '#000',
      'opacity': '0',
      'pointer-events': 'none',
    }),

    // ----- Info column ---------------------------------------------------
    css('.wcard__info').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '1.35rem',
      'padding': 'clamp(1.5rem, 3.4vw, 3.25rem)',
      'min-width': '0',
    }),
    css('.wcard__meta').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
      'gap': '1rem',
      'flex-wrap': 'wrap',
    }),
    css('.wcard__client').styles(raw: {'color': 'var(--text)'}),
    css('.wcard__title').styles(raw: {
      'font-size': 'clamp(2.7rem, 5.4vw, 5.6rem)',
      'line-height': '0.92',
      'letter-spacing': '-0.055em',
      'margin-top': '0.5rem',
    }),
    css('.wcard__tags').styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'gap': '0.5rem',
    }),
    css('.wcard__tag, .wcard__float').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.55rem',
      'padding': '0.45rem 0.9rem',
      'border': '1px solid var(--line-strong)',
      'border-radius': '999px',
      'font-size': '0.82rem',
      'color': 'var(--text)',
    }),
    css('.wcard__dot').styles(raw: {
      'width': '7px',
      'height': '7px',
      'border-radius': '50%',
      'background': 'var(--tone)',
      'box-shadow': '0 0 12px var(--tone)',
    }),
    css('.wcard__summary').styles(raw: {
      'font-size': 'var(--fs-body-lg)',
      'max-width': '46ch',
    }),
    css('.wcard__hl').styles(raw: {
      'list-style': 'none',
      'border-top': '1px solid var(--line)',
    }),
    css('.wcard__hl li').styles(raw: {
      'display': 'flex',
      'gap': '1rem',
      'padding': '0.8rem 0',
      'border-bottom': '1px solid var(--line)',
      'font-size': '0.95rem',
      'color': 'var(--text)',
    }),
    css('.wcard__hl-idx').styles(raw: {
      'font-family': 'var(--font-mono)',
      'font-size': '0.72rem',
      'padding-top': '0.25rem',
      'color': 'var(--tone)',
    }),
    css('.wcard__stack').styles(raw: {'margin-top': 'auto', 'padding-top': '0.5rem'}),

    // ----- Visual column -------------------------------------------------
    css('.wcard__visual').styles(raw: {
      'position': 'relative',
      'display': 'grid',
      'place-items': 'center',
      'min-height': '440px',
      'padding': '3rem 1rem',
      'overflow': 'hidden',
      'order': '-1',
      'background':
          'radial-gradient(55% 55% at 50% 55%, '
          'color-mix(in srgb, var(--tone) 30%, transparent), transparent 72%)',
      'border-bottom': '1px solid var(--line)',
    }),
    css('.wcard__num').styles(raw: {
      'position': 'absolute',
      'right': '-0.04em',
      'bottom': '-0.2em',
      'font-family': 'var(--font-display)',
      'font-size': 'clamp(9rem, 22vw, 22rem)',
      'font-weight': '600',
      'line-height': '1',
      'letter-spacing': '-0.07em',
      'color': 'transparent',
      '-webkit-text-stroke': '1px color-mix(in srgb, var(--tone) 45%, transparent)',
      'pointer-events': 'none',
      'user-select': 'none',
    }),
    css('.wcard__phone').styles(raw: {
      'position': 'relative',
      'z-index': '1',
    }),
    css('.wcard__phone .phone').styles(raw: {
      'transform': 'rotate(-5deg)',
      'transition': 'transform 1.2s var(--ease-expo)',
    }),
    css('.wcard:hover .wcard__phone .phone').styles(raw: {
      'transform': 'rotate(-2deg) translateY(-8px)',
    }),
    // Store/marketing art shown as a tilted poster instead of a phone.
    css('.wcard__poster').styles(raw: {
      'width': 'clamp(220px, 21vw, 320px)',
      'border-radius': 'var(--radius-lg)',
      'overflow': 'hidden',
      'transform': 'rotate(-5deg)',
      'transition': 'transform 1.2s var(--ease-expo)',
      'box-shadow':
          '0 0 0 1px rgba(255, 255, 255, 0.08), '
          '0 50px 100px -30px rgba(0, 0, 0, 0.85), '
          '0 0 140px -40px color-mix(in srgb, var(--tone) 70%, transparent)',
    }),
    css('.wcard__poster img').styles(raw: {
      'display': 'block',
      'width': '100%',
      'height': '100%',
      'object-fit': 'cover',
    }),
    css('.wcard:hover .wcard__poster').styles(raw: {
      'transform': 'rotate(-2deg) translateY(-8px)',
    }),
    css('.wcard__float').styles(raw: {
      'position': 'absolute',
      'top': '1.5rem',
      'left': '1.5rem',
      'z-index': '2',
      'background': 'var(--glass)',
      'backdrop-filter': 'blur(12px)',
      '-webkit-backdrop-filter': 'blur(12px)',
      'border-color': 'var(--line)',
    }),

    // ----- Desktop: two columns ------------------------------------------
    css.media(MediaQuery.raw('(min-width: 900px)'), [
      css('.wcard').styles(raw: {
        'grid-template-columns': 'minmax(0, 1.08fr) minmax(0, 0.92fr)',
      }),
      css('.wcard__visual').styles(raw: {
        'order': '0',
        'min-height': '0',
        'border-bottom': '0',
        'border-left': '1px solid var(--line)',
      }),
    ]),
    css.media(maxWidth(AppSpacing.bpSm), [
      css('.wcard__visual').styles(raw: {'min-height': '380px'}),
      css('.wcard__float').styles(raw: {'display': 'none'}),
    ]),
  ];
}

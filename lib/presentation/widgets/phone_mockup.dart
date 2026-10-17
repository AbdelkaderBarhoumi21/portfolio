// Decorative, CSS-drawn phone showing a stylized app screen.
//
// No screenshots needed: each `mock` variant draws a recognisable UI
// (fitness rings, bowling score sheet, product grid, IoT sensor panel)
// tinted with the parent's `--tone`. Sizes inside the screen use
// container-query units, so the whole device scales as one piece.
//
// Purely presentational — wrapped in aria-hidden. The sample strings are
// UI filler, not profile content.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class PhoneMockup extends StatelessComponent {
  const PhoneMockup({
    required this.title,
    required this.eyebrow,
    required this.mock,
    super.key,
  });

  /// App name shown in the screen header.
  final String title;

  /// Small caption above the title (e.g. the category).
  final String eyebrow;

  /// 'fitness' | 'bowling' | 'commerce' | 'iot'.
  final String mock;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'phone',
      attributes: {'aria-hidden': 'true', 'data-mock': mock},
      [
        div(classes: 'phone__screen', [
          div(classes: 'phone__island', []),
          div(classes: 'phone__status', [
            span([Component.text('9:41')]),
            span(classes: 'phone__signal', [span([]), span([]), span([])]),
          ]),
          div(classes: 'phone__head', [
            span(classes: 'phone__eyebrow', [Component.text(eyebrow)]),
            span(classes: 'phone__title', [Component.text(title)]),
          ]),
          div(classes: 'phone__body', _body()),
          div(classes: 'phone__tabbar', [
            span(classes: 'is-on', []),
            span([]),
            span([]),
            span([]),
          ]),
        ]),
      ],
    );
  }

  List<Component> _body() => switch (mock) {
    'fitness' => _fitness(),
    'bowling' => _bowling(),
    'commerce' => _commerce(),
    _ => _iot(),
  };

  // ---------------------------------------------------------------- fitness
  static List<Component> _fitness() => [
    div(classes: 'mk-ring', [
      div(classes: 'mk-ring__value', [
        b([Component.text('72%')]),
        i([Component.text('Weekly goal')]),
      ]),
    ]),
    _row('Upper body', '45 min · 8 exercises', 0.8),
    _row('Mobility', '20 min · 5 exercises', 0.45),
    _row('Coach chat', '2 new messages', null),
  ];

  // ---------------------------------------------------------------- bowling
  static List<Component> _bowling() => [
    div(classes: 'mk-total', [
      div([
        i([Component.text('Total score')]),
        b([Component.text('246')]),
      ]),
      span(classes: 'mk-pill', [Component.text('Strike!')]),
    ]),
    div(classes: 'mk-score', [
      for (final f in const ['X', '9/', 'X', 'X', '8/', 'X', '7/', 'X', 'X', 'X9'])
        span(classes: f.startsWith('X') ? 'is-strike' : null, [Component.text(f)]),
    ]),
    _row('Lane 04', 'Available now', null),
    _row('Lane 07', 'Booked · 19:30', null),
  ];

  // --------------------------------------------------------------- commerce
  static List<Component> _commerce() => [
    div(classes: 'mk-search', [Component.text('Search products…')]),
    div(classes: 'mk-grid', [
      for (final t in const [('Pallet A', '120'), ('Crate B', '84'), ('Box C', '36'), ('Kit D', '210')])
        div(classes: 'mk-tile', [
          div(classes: 'mk-tile__img', []),
          b([Component.text(t.$1)]),
          i([Component.text('AED ${t.$2}')]),
        ]),
    ]),
    div(classes: 'mk-cta', [
      span([Component.text('Checkout')]),
      span([Component.text('3 items')]),
    ]),
  ];

  // -------------------------------------------------------------------- iot
  static List<Component> _iot() => [
    div(classes: 'mk-device', [
      span(classes: 'mk-device__dot', []),
      div([
        b([Component.text('Sensor A1')]),
        i([Component.text('Connected · BLE')]),
      ]),
    ]),
    div(classes: 'mk-readout', [
      i([Component.text('Live reading')]),
      b([Component.text('23.4°')]),
    ]),
    div(classes: 'mk-spark', [
      for (final h in const [38, 52, 44, 70, 58, 82, 64, 90, 72, 60, 78, 95])
        span(attributes: {'style': '--h: $h%'}, []),
    ]),
    _row('Cloud sync', 'Up to date · offline-first', null),
    _row('Gateway B2', 'Wi-Fi · 3 sensors', null),
  ];

  static Component _row(String title, String sub, double? progress) =>
      div(classes: 'mk-row', [
        span(classes: 'mk-row__icon', []),
        div(classes: 'mk-row__text', [
          b([Component.text(title)]),
          i([Component.text(sub)]),
          if (progress != null)
            span(
              classes: 'mk-bar',
              attributes: {'style': '--w: ${(progress * 100).round()}%'},
              [],
            ),
        ]),
      ]);

  @css
  static List<StyleRule> get styles => [
    // ----- Device ---------------------------------------------------------
    css('.phone').styles(raw: {
      'position': 'relative',
      'width': 'clamp(200px, 19vw, 290px)',
      'aspect-ratio': '9 / 19.3',
      'padding': '3.2%',
      'border-radius': '15% / 7%',
      'background': 'linear-gradient(150deg, #34343c, #0c0c0f 38%, #1d1d22 70%, #3a3a42)',
      'box-shadow':
          '0 0 0 1px rgba(255, 255, 255, 0.07), '
          '0 50px 100px -30px rgba(0, 0, 0, 0.85), '
          '0 0 140px -40px color-mix(in srgb, var(--tone) 70%, transparent)',
      'container-type': 'inline-size',
    }),
    css('.phone__screen').styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '3.6cqw',
      'height': '100%',
      'padding': '5cqw 5.5cqw 4cqw',
      'border-radius': '12% / 5.6%',
      'overflow': 'hidden',
      'background': '#0B0B0E',
      'color': '#EDEDF0',
      'font-family': 'var(--font-body)',
      'font-size': '4.3cqw',
      'line-height': '1.25',
    }),
    css('.phone__screen::before').styles(raw: {
      'content': '""',
      'position': 'absolute',
      'inset': '0 0 auto 0',
      'height': '48%',
      'background':
          'radial-gradient(90% 70% at 70% 0%, '
          'color-mix(in srgb, var(--tone) 42%, transparent), transparent 70%)',
      'pointer-events': 'none',
    }),
    css('.phone__screen > *').styles(raw: {'position': 'relative'}),
    css('.phone__island').styles(raw: {
      'position': 'absolute !important',
      'top': '3.4cqw',
      'left': '50%',
      'width': '30%',
      'height': '7.4cqw',
      'transform': 'translateX(-50%)',
      'border-radius': '99px',
      'background': '#000',
      'z-index': '2',
    }),
    css('.phone__status').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
      'align-items': 'center',
      'padding': '0.4cqw 3cqw 0',
      'font-size': '3.6cqw',
      'font-weight': '600',
    }),
    css('.phone__signal').styles(raw: {
      'display': 'inline-flex',
      'align-items': 'flex-end',
      'gap': '0.8cqw',
    }),
    css('.phone__signal span').styles(raw: {
      'width': '1.1cqw',
      'border-radius': '1px',
      'background': '#EDEDF0',
    }),
    css('.phone__signal span:nth-child(1)').styles(raw: {'height': '1.6cqw'}),
    css('.phone__signal span:nth-child(2)').styles(raw: {'height': '2.4cqw'}),
    css('.phone__signal span:nth-child(3)').styles(raw: {'height': '3.2cqw'}),
    css('.phone__head').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.8cqw',
      'margin-top': '3cqw',
    }),
    css('.phone__eyebrow').styles(raw: {
      'font-family': 'var(--font-mono)',
      'font-size': '2.9cqw',
      'letter-spacing': '0.12em',
      'text-transform': 'uppercase',
      'opacity': '0.6',
    }),
    css('.phone__title').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': '8cqw',
      'font-weight': '600',
      'letter-spacing': '-0.03em',
      'line-height': '1.05',
    }),
    css('.phone__body').styles(raw: {
      'flex': '1',
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '3cqw',
      'min-height': '0',
    }),
    css('.phone__tabbar').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-around',
      'padding': '3.4cqw 2cqw 1cqw',
      'border-top': '1px solid rgba(255, 255, 255, 0.07)',
    }),
    css('.phone__tabbar span').styles(raw: {
      'width': '5.5cqw',
      'height': '5.5cqw',
      'border-radius': '1.8cqw',
      'background': 'rgba(255, 255, 255, 0.12)',
    }),
    css('.phone__tabbar span.is-on').styles(raw: {'background': 'var(--tone)'}),

    // ----- Shared mock atoms ---------------------------------------------
    css('.phone b').styles(raw: {'font-weight': '600'}),
    css('.phone i').styles(raw: {'font-style': 'normal', 'opacity': '0.55', 'font-size': '0.85em'}),
    css('.mk-row').styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'gap': '3cqw',
      'padding': '3cqw',
      'border-radius': '4.5cqw',
      'background': 'rgba(255, 255, 255, 0.055)',
    }),
    css('.mk-row__icon').styles(raw: {
      'flex-shrink': '0',
      'width': '10cqw',
      'height': '10cqw',
      'border-radius': '3.2cqw',
      'background':
          'linear-gradient(140deg, var(--tone), '
          'color-mix(in srgb, var(--tone) 25%, transparent))',
    }),
    css('.mk-row__text').styles(raw: {
      'flex': '1',
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.8cqw',
      'min-width': '0',
    }),
    css('.mk-bar').styles(raw: {
      'position': 'relative',
      'height': '1.4cqw',
      'margin-top': '1cqw',
      'border-radius': '99px',
      'background': 'rgba(255, 255, 255, 0.08)',
      'overflow': 'hidden',
    }),
    css('.mk-bar::after').styles(raw: {
      'content': '""',
      'position': 'absolute',
      'inset': '0 auto 0 0',
      'width': 'var(--w, 50%)',
      'border-radius': 'inherit',
      'background': 'var(--tone)',
    }),
    css('.mk-pill').styles(raw: {
      'padding': '1.6cqw 3.4cqw',
      'border-radius': '99px',
      'background': 'var(--tone)',
      'color': '#0B0B0E',
      'font-weight': '600',
      'font-size': '3.4cqw',
    }),

    // ----- fitness ----------------------------------------------------------
    css('.mk-ring').styles(raw: {
      'position': 'relative',
      'display': 'grid',
      'place-items': 'center',
      'width': '60%',
      'aspect-ratio': '1',
      'margin': '1cqw auto 2cqw',
      'border-radius': '50%',
      'background':
          'conic-gradient(var(--tone) 0 72%, rgba(255, 255, 255, 0.08) 72% 100%)',
    }),
    css('.mk-ring::after').styles(raw: {
      'content': '""',
      'position': 'absolute',
      'inset': '9%',
      'border-radius': '50%',
      'background': '#0B0B0E',
    }),
    css('.mk-ring__value').styles(raw: {
      'position': 'relative',
      'z-index': '1',
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
    }),
    css('.mk-ring__value b').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': '11cqw',
      'letter-spacing': '-0.04em',
      'line-height': '1',
    }),

    // ----- bowling ----------------------------------------------------------
    css('.mk-total').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
      'align-items': 'flex-end',
      'padding': '4cqw',
      'border-radius': '5cqw',
      'background':
          'linear-gradient(135deg, color-mix(in srgb, var(--tone) 38%, transparent), '
          'rgba(255, 255, 255, 0.04))',
    }),
    css('.mk-total div').styles(raw: {'display': 'flex', 'flex-direction': 'column'}),
    css('.mk-total b').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': '14cqw',
      'letter-spacing': '-0.05em',
      'line-height': '1',
    }),
    css('.mk-score').styles(raw: {
      'display': 'grid',
      'grid-template-columns': 'repeat(5, 1fr)',
      'gap': '1.6cqw',
    }),
    css('.mk-score span').styles(raw: {
      'display': 'grid',
      'place-items': 'center',
      'aspect-ratio': '1',
      'border-radius': '2.6cqw',
      'background': 'rgba(255, 255, 255, 0.06)',
      'font-family': 'var(--font-display)',
      'font-weight': '600',
      'font-size': '4.2cqw',
    }),
    css('.mk-score span.is-strike').styles(raw: {
      'background': 'var(--tone)',
      'color': '#0B0B0E',
    }),

    // ----- commerce ---------------------------------------------------------
    css('.mk-search').styles(raw: {
      'padding': '3.2cqw 4.4cqw',
      'border-radius': '99px',
      'background': 'rgba(255, 255, 255, 0.07)',
      'color': 'rgba(237, 237, 240, 0.55)',
      'font-size': '3.6cqw',
    }),
    css('.mk-grid').styles(raw: {
      'display': 'grid',
      'grid-template-columns': '1fr 1fr',
      'gap': '2.6cqw',
    }),
    css('.mk-tile').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.8cqw',
      'padding': '2cqw',
      'border-radius': '4cqw',
      'background': 'rgba(255, 255, 255, 0.05)',
      'font-size': '3.5cqw',
    }),
    css('.mk-tile__img').styles(raw: {
      'aspect-ratio': '1.25',
      'margin-bottom': '1cqw',
      'border-radius': '3cqw',
      'background':
          'linear-gradient(140deg, color-mix(in srgb, var(--tone) 55%, transparent), '
          'rgba(255, 255, 255, 0.04))',
    }),
    css('.mk-tile:nth-child(2) .mk-tile__img, .mk-tile:nth-child(3) .mk-tile__img').styles(raw: {
      'background':
          'linear-gradient(200deg, color-mix(in srgb, var(--tone) 25%, transparent), '
          'rgba(255, 255, 255, 0.06))',
    }),
    css('.mk-cta').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
      'margin-top': 'auto',
      'padding': '3.8cqw 4.4cqw',
      'border-radius': '4.5cqw',
      'background': 'var(--tone)',
      'color': '#0B0B0E',
      'font-weight': '600',
    }),

    // ----- iot --------------------------------------------------------------
    css('.mk-device').styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'gap': '3cqw',
      'padding': '3.4cqw',
      'border-radius': '4.5cqw',
      'border': '1px solid color-mix(in srgb, var(--tone) 45%, transparent)',
      'background': 'color-mix(in srgb, var(--tone) 10%, transparent)',
    }),
    css('.mk-device div').styles(raw: {'display': 'flex', 'flex-direction': 'column'}),
    css('.mk-device__dot').styles(raw: {
      'width': '3cqw',
      'height': '3cqw',
      'border-radius': '50%',
      'background': 'var(--tone)',
      'box-shadow': '0 0 0 2cqw color-mix(in srgb, var(--tone) 22%, transparent)',
    }),
    css('.mk-readout').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'padding': '1cqw 1cqw 0',
    }),
    css('.mk-readout b').styles(raw: {
      'font-family': 'var(--font-display)',
      'font-size': '17cqw',
      'letter-spacing': '-0.055em',
      'line-height': '1',
    }),
    css('.mk-spark').styles(raw: {
      'display': 'flex',
      'align-items': 'flex-end',
      'gap': '1.4cqw',
      'height': '20cqw',
    }),
    css('.mk-spark span').styles(raw: {
      'flex': '1',
      'height': 'var(--h, 50%)',
      'border-radius': '1.2cqw 1.2cqw 0.4cqw 0.4cqw',
      'background':
          'linear-gradient(180deg, var(--tone), '
          'color-mix(in srgb, var(--tone) 20%, transparent))',
    }),
  ];
}

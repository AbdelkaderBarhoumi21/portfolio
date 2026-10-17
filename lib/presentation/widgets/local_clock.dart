// Live local time for a time zone — filled in by the motion script
// (`[data-clock]`), with a neutral placeholder in the static HTML.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class LocalClock extends StatelessComponent {
  const LocalClock({required this.timeZone, super.key});

  /// IANA zone, e.g. 'Africa/Tunis'.
  final String timeZone;

  @override
  Component build(BuildContext context) {
    return span(
      classes: 'clock',
      attributes: {'data-clock': timeZone},
      [Component.text('--:--')],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.clock').styles(raw: {
      'font-variant-numeric': 'tabular-nums',
    }),
  ];
}

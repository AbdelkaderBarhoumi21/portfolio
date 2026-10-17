// A headline number on the About section ("05+ apps shipped").
//
// `value` is numeric so the counter animation can tween it; `pad` zero-pads
// the rendered number ("5" → "05") for a tidy editorial look.

class Stat {
  final int value;
  final String suffix;   // '+', '' …
  final String label;
  final int pad;

  const Stat({
    required this.value,
    required this.label,
    this.suffix = '',
    this.pad = 2,
  });
}

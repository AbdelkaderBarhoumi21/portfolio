// Small UI glyphs (arrows, download, copy …) as inline SVG strings.
//
// Lucide-style 24×24 outline icons using `currentColor`, rendered through
// `RawText` so they inherit the surrounding text color and size (1em).

String _icon(String d) =>
    '<svg viewBox="0 0 24 24" width="1em" height="1em" fill="none" '
    'stroke="currentColor" stroke-width="1.75" stroke-linecap="round" '
    'stroke-linejoin="round" aria-hidden="true">$d</svg>';

abstract final class UiIcons {
  static final String arrowRight = _icon('<path d="M5 12h14"/><path d="m13 6 6 6-6 6"/>');
  static final String arrowUpRight = _icon('<path d="M7 17 17 7"/><path d="M8 7h9v9"/>');
  static final String arrowDown = _icon('<path d="M12 5v14"/><path d="m6 13 6 6 6-6"/>');
  static final String arrowUp = _icon('<path d="M12 19V5"/><path d="m6 11 6-6 6 6"/>');
  static final String download = _icon(
    '<path d="M12 4v11"/><path d="m7 10 5 5 5-5"/><path d="M5 20h14"/>',
  );
  static final String copy = _icon(
    '<rect x="9" y="9" width="11" height="11" rx="2"/>'
    '<path d="M5 15V6a2 2 0 0 1 2-2h9"/>',
  );
  static final String phone = _icon(
    '<path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1.9.4 1.8.7 2.7a2 2 0 0 1-.5 2.1L8 9.8a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.4c.9.3 1.8.6 2.7.7a2 2 0 0 1 1.7 2z"/>',
  );
  static final String pin = _icon(
    '<path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0z"/><circle cx="12" cy="10" r="3"/>',
  );
  static final String sparkle = _icon(
    '<path d="M12 3v4M12 17v4M3 12h4M17 12h4M6.3 6.3l2.5 2.5M15.2 15.2l2.5 2.5M6.3 17.7l2.5-2.5M15.2 8.8l2.5-2.5"/>',
  );
}

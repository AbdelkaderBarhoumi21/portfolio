// A real app screenshot shown on a case-study card.
//
// `framed: true`  → drawn inside the CSS phone mockup (plain app screens).
// `framed: false` → shown as a tilted poster card (store/marketing art that
//                   already contains its own device frame).
//
// width/height are the intrinsic pixel size, so the browser can reserve the
// right box before the file loads.

class Screenshot {
  final String path;   // relative to web/, e.g. 'images/work/medlink.png'
  final int width;
  final int height;
  final bool framed;

  const Screenshot({
    required this.path,
    required this.width,
    required this.height,
    this.framed = true,
  });
}

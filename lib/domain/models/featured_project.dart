// A client product shown as a large case-study card in "Selected work".
//
// `tone` picks the accent color (see AppColors.tones) and `mock` picks the
// decorative phone-screen layout drawn by the PhoneMockup widget. Both are
// plain strings so this model stays free of any presentation imports.

class FeaturedProject {
  final String name;             // 'Sparta Coaching'
  final String client;           // 'Oxton Digital'
  final String year;             // '2026'
  final String category;         // 'Fitness & coaching'
  final String platforms;        // 'iOS · Android'
  final String summary;          // 1–2 sentence pitch
  final List<String> highlights; // 3 short engineering highlights
  final List<String> stack;      // tech chips
  final String tone;             // 'violet' | 'cyan' | 'amber' | 'emerald' | 'rose'
  final String mock;             // 'fitness' | 'bowling' | 'commerce' | 'iot'
  final String? url;             // store / case-study link, when public

  const FeaturedProject({
    required this.name,
    required this.client,
    required this.year,
    required this.category,
    required this.platforms,
    required this.summary,
    required this.highlights,
    required this.stack,
    required this.tone,
    required this.mock,
    this.url,
  });
}

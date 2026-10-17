// A client product shown as a large case-study card in "Selected work".
//
// `tone` picks the accent color (see AppColors.tones). The visual is the
// real `screenshot` when there is one; otherwise `mock` picks a decorative
// CSS-drawn phone screen. All plain data, so this model stays free of any
// presentation imports.

import 'screenshot.dart';

class FeaturedProject {
  final String name;             // 'Sparta Coaching'
  final String client;           // 'Oxton Digital'
  final String year;             // '2026'
  final String category;         // 'Fitness & coaching'
  final String platforms;        // 'iOS · Android'
  final String summary;          // 1–2 sentence pitch
  final List<String> highlights; // 3 short engineering highlights
  final List<String> stack;      // tech chips
  final String tone;             // key of AppColors.tones, e.g. 'gold'
  final String mock;             // 'fitness' | 'bowling' | 'commerce' | 'iot'
  final Screenshot? screenshot;  // real app screen, preferred over `mock`
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
    this.screenshot,
    this.url,
  });
}

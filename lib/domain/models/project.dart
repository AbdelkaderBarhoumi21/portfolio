// A personal project shown in the horizontal "Lab" strip.
//
// `repoUrl` and `demoUrl` are nullable — not every project has a public link.

class Project {
  final String title;            // 'Real-time Chat App'
  final String year;             // '2025'
  final String description;      // 1–2 sentence summary
  final List<String> highlights; // short bullet points
  final List<String> tags;       // ['Flutter', 'Rust', 'WebSockets', …]
  final String tone;             // accent key, see AppColors.tones
  final String? repoUrl;         // GitHub or other source link
  final String? demoUrl;         // live demo, store listing, etc.

  const Project({
    required this.title,
    required this.year,
    required this.description,
    required this.highlights,
    required this.tags,
    required this.tone,
    this.repoUrl,
    this.demoUrl,
  });
}

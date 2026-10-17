// A single job entry rendered in the experience list.
//
// `period` is a human-readable string ("Apr 2026 – Present") rather than two
// DateTimes because the data comes from the CV verbatim and never needs to
// be sorted/compared programmatically.

class Experience {
  final String company;          // 'Oxton Digital'
  final String role;             // 'Mobile Lead — Flutter & Android'
  final String location;         // 'Tunis, Tunisia'
  final String employment;       // 'Full-time · On-site'
  final String period;           // 'Apr 2026 – Present'
  final bool current;            // true while the role is ongoing
  final List<String> bullets;    // achievement bullets
  final List<String> tech;       // tech chips rendered under the bullets

  const Experience({
    required this.company,
    required this.role,
    required this.location,
    required this.employment,
    required this.period,
    required this.bullets,
    required this.tech,
    this.current = false,
  });
}

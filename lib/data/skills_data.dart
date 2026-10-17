// Grouped skill list rendered as rows in the Capabilities section,
// plus the curated words that scroll through the marquee band.
//
// Order inside each group is curated, not alphabetical — the most important
// or signature tools come first so the eye lands on them.

import '../domain/models/skill_group.dart';

const List<SkillGroup> skillGroups = [
  SkillGroup(
    title: 'Mobile — Flutter',
    skills: [
      'Flutter', 'Dart', 'BLoC/Cubit', 'Riverpod', 'GetX',
      'Clean Architecture', 'MVVM', 'Material 3', 'Responsive UI',
      'Testing (Unit/Widget/Integration)',
    ],
  ),
  SkillGroup(
    title: 'Android Native',
    skills: [
      'Kotlin', 'Jetpack Compose', 'XML Layouts', 'Java', 'Android SDK',
      'Migration XML+Java → Kotlin+Compose',
    ],
  ),
  SkillGroup(
    title: 'Backend & Real-time',
    skills: [
      'Node.js (Express)', 'Rust (Axum)', 'PHP (Laravel)',
      'WebSockets (Socket.IO)', 'Stream.io', 'Auth (JWT/OAuth2)',
    ],
  ),
  SkillGroup(
    title: 'Data & Storage',
    skills: [
      'PostgreSQL', 'MySQL', 'MongoDB', 'Firebase/Firestore', 'Supabase',
      'Appwrite', 'Drift', 'ObjectBox',
    ],
  ),
  SkillGroup(
    title: 'DevOps & Tooling',
    skills: [
      'Git/GitHub', 'CI/CD', 'Docker', 'Fastlane',
      'Firebase Crashlytics/Analytics', 'REST', 'OpenAPI/Swagger', 'Figma',
    ],
  ),
];

/// Words for the infinite marquee band under the hero.
const List<String> marqueeWords = [
  'Flutter',
  'Kotlin',
  'Jetpack Compose',
  'Dart',
  'BLoC',
  'Riverpod',
  'Firebase',
  'BLE & IoT',
  'Rust',
  'Clean Architecture',
];

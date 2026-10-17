// Personal projects rendered in the horizontal "Lab" strip.
//
// `repoUrl` / `demoUrl` are intentionally null below — fill in as the public
// repos/demos become available. The card hides the link affordance when
// these are null.

import '../domain/models/project.dart';

const List<Project> projects = [
  Project(
    title: 'Multi-role Commerce Platform',
    year: '2025',
    description:
        'Three Flutter apps — Admin, Delivery and Customer — on one Laravel '
        'REST API with JWT auth and role management.',
    highlights: [
      'Courier live-tracking with Google Maps',
      'Qt/QML desktop dashboard',
      'PostgreSQL / MySQL backend',
    ],
    tags: ['Flutter', 'BLoC/Cubit', 'Laravel', 'JWT', 'PostgreSQL', 'Qt/QML', 'Docker'],
    tone: 'violet',
  ),
  Project(
    title: 'Real-time Chat',
    year: '2025',
    description:
        'Group messaging with online & typing status, read receipts, media '
        'sharing, search and blocking.',
    highlights: [
      'Rust (Axum) WebSocket backend',
      'JWT auth with MongoDB persistence',
      'Riverpod on the Flutter client',
    ],
    tags: ['Flutter', 'Riverpod', 'Rust (Axum)', 'WebSockets', 'JWT', 'MongoDB'],
    tone: 'cyan',
  ),
  Project(
    title: 'Smart Irrigation & Plant Shop',
    year: '2024',
    description:
        'Smart irrigation control plus a plant shop with catalog, cart and '
        'notifications, secured with access rules and Cloud Functions.',
    highlights: [
      'Gemini-powered chatbot with streaming replies',
      'Location-based weather with offline caching',
      'GetX + Clean Architecture, Rust (Axum) services',
    ],
    tags: ['Flutter', 'GetX', 'Rust (Axum)', 'Gemini API', 'Firebase', 'Docker'],
    tone: 'emerald',
  ),
];

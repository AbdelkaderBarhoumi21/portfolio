// Client products shown as stacked case-study cards in "Selected work".
//
// Order = display order. Keep it to the strongest 3–5 products.

import '../domain/models/featured_project.dart';

const List<FeaturedProject> featuredWork = [
  FeaturedProject(
    name: 'Sparta Coaching',
    client: 'Oxton Digital',
    year: '2026',
    category: 'Fitness & coaching',
    platforms: 'iOS · Android',
    summary:
        'A cross-platform fitness app for workout tracking, a full exercise '
        'library and training-plan management — with real-time chat between '
        'coaches and athletes.',
    highlights: [
      'Feature modules driven by BLoC/Cubit state management',
      'Real-time coach ↔ athlete messaging on GetStream.io',
      'Crash monitoring and push with Firebase Crashlytics & FCM',
    ],
    stack: ['Flutter', 'Dart', 'BLoC/Cubit', 'GetStream.io', 'Firebase', 'REST APIs'],
    tone: 'violet',
    mock: 'fitness',
  ),
  FeaturedProject(
    name: 'Fun Bowling',
    client: 'Oxton Digital × Digi Service',
    year: '2026',
    category: 'Entertainment · France',
    platforms: 'Native Android',
    summary:
        'Led the migration of a live bowling entertainment app from XML + Java '
        'to Kotlin + Jetpack Compose, introducing Clean Architecture and modern '
        'UI patterns along the way.',
    highlights: [
      'Legacy XML + Java screens rebuilt in Kotlin + Jetpack Compose',
      'Clean Architecture layers introduced across the codebase',
      'Modern, declarative UI patterns replacing legacy views',
    ],
    stack: ['Kotlin', 'Jetpack Compose', 'Java', 'XML', 'Clean Architecture'],
    tone: 'amber',
    mock: 'bowling',
  ),
  FeaturedProject(
    name: 'Masdary',
    client: 'Stoneslane · Dubai',
    year: '2025 — Now',
    category: 'B2B e-commerce',
    platforms: 'iOS · Android',
    summary:
        'A B2B commerce app — authentication, catalog, cart and checkout, order '
        'tracking and push notifications — live on Google Play and the App Store.',
    highlights: [
      'REST APIs and payment gateways in scalable BLoC/Cubit modules',
      'Offline persistence with ObjectBox, instant search with Algolia',
      'Unit, widget and integration tests with Fastlane CI/CD',
    ],
    stack: ['Flutter', 'BLoC/Cubit', 'ObjectBox', 'Algolia', 'Firebase', 'Google Maps', 'Fastlane'],
    tone: 'cyan',
    mock: 'commerce',
  ),
  FeaturedProject(
    name: 'Wergo',
    client: 'Sifartek · Algiers',
    year: '2026',
    category: 'IoT · Connected sensors',
    platforms: 'Flutter · BLE',
    summary:
        'A Flutter app that talks to IoT sensors over BLE and Wi-Fi, with '
        'offline-first local storage that syncs to the cloud automatically.',
    highlights: [
      'BLE (MDS, Nordic) and Wi-Fi connectivity layers',
      'Offline-first storage with Drift + automatic cloud sync',
      'Unit, widget and integration test coverage',
    ],
    stack: ['Flutter', 'BLoC/Cubit', 'BLE', 'Drift', 'OpenAPI', 'Firebase'],
    tone: 'emerald',
    mock: 'iot',
  ),
];

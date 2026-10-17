// Professional experience data — mirrors the CV.
//
// Order: current roles first, then past roles in reverse chronological order.
// Bullets lead with verbs and name concrete tech explicitly.

import '../domain/models/experience.dart';

const List<Experience> experiences = [
  // ---- Current ----------------------------------------------------------
  Experience(
    company: 'Oxton Digital',
    role: 'Mobile Lead — Flutter & Android',
    location: 'Tunis, Tunisia',
    employment: 'Full-time · On-site',
    period: 'Apr 2026 — Present',
    current: true,
    bullets: [
      'Lead the Mobile Department, overseeing Flutter and native Android delivery across client projects.',
      'Managed the migration of the Fun Bowling entertainment app (Digi Service, France) from XML + Java to Kotlin + Jetpack Compose, introducing Clean Architecture and modern UI patterns.',
      'Built Sparta Coaching, a cross-platform fitness app for iOS and Android with BLoC/Cubit, real-time chat via GetStream.io and Firebase Crashlytics monitoring.',
    ],
    tech: [
      'Flutter', 'Dart', 'BLoC/Cubit', 'Kotlin', 'Jetpack Compose', 'Java',
      'GetStream.io', 'Firebase', 'Clean Architecture', 'REST APIs',
    ],
  ),
  Experience(
    company: 'Stoneslane',
    role: 'Mobile Engineer — Flutter',
    location: 'Dubai, UAE',
    employment: 'Contract · Remote',
    period: 'Oct 2025 — Present',
    current: true,
    bullets: [
      'Delivered Masdary, a B2B e-commerce app (auth, catalog, cart/checkout, order tracking, push) published to Google Play and the App Store.',
      'Integrated REST APIs and payment gateways; structured the UI into scalable BLoC/Cubit modules with unit, widget and integration tests.',
      'Added offline persistence with ObjectBox and fast product discovery with Algolia search.',
    ],
    tech: [
      'Flutter', 'BLoC/Cubit', 'ObjectBox', 'Algolia', 'Firebase',
      'Google Maps', 'Payments', 'Fastlane', 'Docker',
    ],
  ),

  // ---- Past -------------------------------------------------------------
  Experience(
    company: 'Sifartek',
    role: 'Mobile Software Engineer — Flutter',
    location: 'Algiers, Algeria',
    employment: 'Contract · Remote',
    period: 'Feb 2026 — Apr 2026',
    bullets: [
      'Built BLE and Wi-Fi connectivity layers for reliable IoT sensor integration in the Wergo Flutter app.',
      'Implemented offline-first local storage with Drift and automatic cloud synchronization to keep data consistent across devices.',
    ],
    tech: [
      'Flutter', 'BLoC/Cubit', 'BLE (MDS, Nordic)', 'OpenAPI', 'Drift',
      'Firebase', 'Cloud Sync', 'Testing',
    ],
  ),
  Experience(
    company: 'Nexits',
    role: 'Mobile Engineer — Flutter',
    location: 'Paris, France',
    employment: 'Contract · Remote',
    period: 'Oct 2025 — Dec 2025',
    bullets: [
      'Built a healthcare app (appointments, patient profiles, notifications, role-based access control) published to Google Play and the App Store.',
      'Generated typed API clients from OpenAPI/Swagger and implemented offline-first storage with Drift, backed by CI/CD automation.',
    ],
    tech: [
      'Flutter', 'Riverpod', 'OpenAPI/Swagger', 'openapi-generator', 'Drift',
      'Firebase', 'CI/CD', 'Fastlane',
    ],
  ),
];

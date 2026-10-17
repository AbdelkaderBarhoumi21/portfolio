// Degrees + certifications rendered in the Education section.

import '../domain/models/certification.dart';
import '../domain/models/education.dart';

const List<Education> education = [
  Education(
    degree: 'Engineering Degree',
    field: 'Embedded Systems & Mobile Development',
    school: 'Polytech International',
    location: 'Tunis, Tunisia',
    period: '2022 — 2025',
  ),
  Education(
    degree: 'Master',
    field: 'Mechatronics',
    school: 'ISET Radès',
    location: 'Radès, Tunisia',
    period: '2022 — 2024',
  ),
  Education(
    degree: 'Bachelor',
    field: 'Industrial Electrical Engineering',
    school: 'ISET Radès',
    location: 'Radès, Tunisia',
    period: '2019 — 2022',
  ),
];

const List<Certification> certifications = [
  Certification(title: 'Claude Code in Action', issuer: 'Anthropic'),
  Certification(title: 'CI/CD with Jenkins and Docker', issuer: 'Udemy'),
  Certification(title: 'The Complete MongoDB Developers Course', issuer: 'Udemy'),
  Certification(title: 'Rust Programming Bootcamp', issuer: 'Udemy'),
  Certification(title: 'Data Structures & OOP with C++ (CS104, CS105)', issuer: 'Udemy'),
  Certification(title: 'NodeJS Projects Bootcamp 2025', issuer: 'Udemy'),
  Certification(title: 'PostgreSQL Bootcamp: Beginner to Advanced', issuer: 'Udemy'),
  Certification(title: 'Flutter & Firebase Chat App', issuer: 'Udemy'),
  Certification(title: 'Dart & Flutter: Complete Development Course', issuer: 'Udemy'),
];

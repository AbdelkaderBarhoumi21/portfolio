// Root component for the portfolio.
//
// This is a static, single-page site — there is no client-side routing.
// `AppLayout` provides the chrome (preloader, navbar, menu, footer, cursor);
// we just hand it the ordered list of scroll sections to render in <main>.

import 'package:jaspr/jaspr.dart';

import 'presentation/layout/app_layout.dart';
import 'presentation/sections/about_section.dart';
import 'presentation/sections/contact_section.dart';
import 'presentation/sections/education_section.dart';
import 'presentation/sections/experience_section.dart';
import 'presentation/sections/hero_section.dart';
import 'presentation/sections/lab_section.dart';
import 'presentation/sections/marquee_band.dart';
import 'presentation/sections/skills_section.dart';
import 'presentation/sections/work_section.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return const AppLayout(
      sections: [
        HeroSection(),
        MarqueeBand(),
        AboutSection(),
        WorkSection(),
        LabSection(),
        ExperienceSection(),
        SkillsSection(),
        EducationSection(),
        ContactSection(),
      ],
    );
  }
}

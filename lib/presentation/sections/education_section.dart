// Education — degrees (left) and certifications (right).

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/constants/app_anchors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/global_styles.dart';
import '../../data/education_data.dart';
import '../widgets/section_header.dart';

class EducationSection extends StatelessComponent {
  const EducationSection({super.key});

  String _two(int n) => n.toString().padLeft(2, '0');

  @override
  Component build(BuildContext context) {
    return section(id: AppAnchors.education, classes: 'section education', [
      div(classes: 'container', [
        const SectionHeader(
          index: '06',
          label: 'Education',
          title: ['Always', '_learning_'],
        ),
        div(classes: 'edu-grid', [
          div(classes: 'edu-col', [
            div(classes: 'edu-col__head label', [
              span([Component.text('Degrees')]),
              span([Component.text(_two(education.length))]),
            ]),
            for (var i = 0; i < education.length; i++)
              article(
                classes: 'edu',
                attributes: {'data-reveal': '', 'style': '--d: ${i * 90}ms'},
                [
                  span(classes: 'label', [Component.text(education[i].period)]),
                  h3(classes: 'edu__degree', [Component.text(education[i].degree)]),
                  p(classes: 'edu__field', [Component.text(education[i].field)]),
                  p(classes: 'label edu__school', [
                    Component.text('${education[i].school} · ${education[i].location}'),
                  ]),
                ],
              ),
          ]),
          div(classes: 'edu-col', [
            div(classes: 'edu-col__head label', [
              span([Component.text('Certifications')]),
              span([Component.text(_two(certifications.length))]),
            ]),
            ol(classes: 'certs', [
              for (var i = 0; i < certifications.length; i++)
                li(
                  classes: 'cert',
                  attributes: {'data-reveal': '', 'style': '--d: ${i * 50}ms'},
                  [
                    span(classes: 'label cert__idx', [Component.text(_two(i + 1))]),
                    span(classes: 'cert__title', [Component.text(certifications[i].title)]),
                    span(classes: 'label cert__issuer', [Component.text(certifications[i].issuer)]),
                  ],
                ),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.edu-grid').styles(raw: {
      'display': 'grid',
      'gap': '4rem',
    }),
    css('.edu-col__head').styles(raw: {
      'display': 'flex',
      'justify-content': 'space-between',
      'padding-bottom': '1.1rem',
      'color': 'var(--text)',
    }),
    css('.edu').styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.45rem',
      'padding-block': '1.75rem',
      'border-top': '1px solid var(--line)',
    }),
    css('.edu__degree').styles(raw: {
      'margin-top': '0.35rem',
      'font-size': 'clamp(1.5rem, 2.4vw, 2.1rem)',
      'letter-spacing': '-0.04em',
    }),
    css('.edu__field').styles(raw: {'color': 'var(--text)'}),
    css('.certs').styles(raw: {'border-bottom': '1px solid var(--line)'}),
    css('.cert').styles(raw: {
      'display': 'grid',
      'grid-template-columns': '2.5rem minmax(0, 1fr) auto',
      'align-items': 'baseline',
      'gap': '1rem',
      'padding-block': '1.05rem',
      'border-top': '1px solid var(--line)',
    }),
    css('.cert__title').styles(raw: {
      'color': 'var(--text)',
      'transition': 'transform 0.6s var(--ease-expo)',
    }),
    css('.cert:hover .cert__title').styles(raw: {'transform': 'translateX(0.35rem)'}),
    css('.cert:hover .cert__idx').styles(raw: {'color': 'var(--primary)'}),
    css.media(minWidth(AppSpacing.bpLg), [
      css('.edu-grid').styles(raw: {
        'grid-template-columns': 'minmax(0, 0.9fr) minmax(0, 1.1fr)',
        'gap': '6vw',
      }),
    ]),
  ];
}

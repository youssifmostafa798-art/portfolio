import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/widgets/project_card.dart';
import 'package:portfolio/core/widgets/section_label.dart';
import 'package:portfolio/features/home/models/project.dart';

class ProjectsSection extends StatelessWidget {
  final void Function(String projectId)? onCaseStudyTap;

  const ProjectsSection({super.key, this.onCaseStudyTap});

  static const List<Project> _projects = [
    Project(
      id: 'vitaguard',
      title: 'VitaGuard',
      subtitle: 'Real-Time Health Monitoring System',
      description:
          'A production-grade medical monitoring system that integrates ESP32 '
          'wearable hardware with a Flutter mobile application. Features '
          'real-time vital sign monitoring, on-device AI chest X-ray analysis, '
          'multi-role authentication (patient, doctor, companion, facility), '
          'and an offline-first architecture with automatic sync.',
      role: 'Flutter Mobile Application Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Supabase',
        'Riverpod',
        'TFLite',
        'Drift',
        'ESP32',
      ],
      highlights: [
        'Real-time health monitoring with sub-second vital sign delivery via WebSocket',
        'On-device AI chest X-ray classification using DenseNet121 with GPU acceleration',
        'Multi-role auth system with 4 distinct user flows and secure companion linking',
        'Offline-first architecture with Drift SQLite sync queue for data resilience',
      ],
      githubUrl: 'https://github.com/youssifmostafa798-art/vitaguard_app.git',
      demoUrl:
          'https://drive.google.com/drive/folders/1H8eaAhWB0pJYPRR3H30GP1JRYmBK0s1R?usp=sharing',
      googleDriveScreenshotsUrl:
          'https://drive.google.com/drive/folders/1L3Hf67WcEH76gWpr18T8MGqCamE4ULES?usp=sharing',
      caseStudyRoute: '/project/vitaguard',
    ),
    Project(
      id: 'hungryy',
      title: 'Hungryy',
      subtitle: 'Food Ordering Application',
      description:
          'A production-grade food ordering application built entirely in Flutter. '
          'Features real-time product browsing with category filtering, dynamic cart '
          'management with tax and delivery fee calculations, multi-step checkout '
          'with animated confirmation, user authentication with persistent JWT sessions, '
          'and a glassmorphism-driven UI system.',
      role: 'Flutter Mobile Application Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Provider',
        'Dio',
        'REST API',
        'SharedPreferences',
      ],
      highlights: [
        'Complete end-to-end food ordering flow from browsing to checkout',
        'Glassmorphism navigation with animated pill indicator and backdrop blur',
        'Provider-based cart with real-time price calculations including tax and delivery',
        'Feature-based architecture with repository pattern and reusable component library',
      ],
      githubUrl: 'https://github.com/youssifmostafa798-art/hungryy',
      caseStudyRoute: '/case-study/hungryy',
      logoAsset: 'assets/images/logo hungry.png',
      cardSubtitle: 'Food Ordering Application',
      cardGradientColors: [
        Color(0xFF0F3D2E),
        Color(0xFF145A32),
        Color(0xFF0F3D2E),
      ],
      cardGlowColor: Color(0xFF27AE60),
      cardLogoGradientColors: [Color(0xFF0F3D2E), Color(0xFF145A32)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final sectionVertical = context.responsiveSectionVertical;
    final sectionGap = context.responsiveSectionGap;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
            label: 'Projects',
            subtitle: 'Featured work and case studies.',
          ),
          SizedBox(height: sectionGap),
          ..._projects.map((project) {
            return Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 24 : 32),
              child: ProjectCard(
                project: project,
                onCaseStudyTap: () {
                  onCaseStudyTap?.call(project.id);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

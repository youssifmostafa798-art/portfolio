import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/widgets/project_card.dart';
import 'package:portfolio/core/widgets/section_label.dart';
import 'package:portfolio/features/home/models/project.dart';

class ProjectsSection extends StatelessWidget {
  final void Function(String projectId)? onCaseStudyTap;

  const ProjectsSection({
    super.key,
    this.onCaseStudyTap,
  });

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
      githubUrl: 'https://github.com/youssifmostafa798-art',
      demoUrl:
          'https://drive.google.com/drive/folders/1H8eaAhWB0pJYPRR3H30GP1JRYmBK0s1R?usp=sharing',
      googleDriveScreenshotsUrl:
          'https://drive.google.com/drive/folders/1L3Hf67WcEH76gWpr18T8MGqCamE4ULES?usp=sharing',
      caseStudyRoute: '/project/vitaguard',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: AppSpacing.sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
            label: 'Projects',
            subtitle: 'Featured work and case studies.',
          ),
          SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.xxxl),
          ..._projects.map((project) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
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

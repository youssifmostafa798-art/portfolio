import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ProjectOverviewSection extends StatelessWidget {
  final ProjectData data;
  const ProjectOverviewSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDark = responsive.isDark;
    final isMobile = responsive.isMobile;
    final sectionVertical = context.responsiveSectionVertical;
    final sectionGap = context.responsiveSectionGap;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Project Overview',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.overviewSubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          if (isMobile)
            _buildMobileLayout(context, isDark, isMobile)
          else
            _buildDesktopLayout(context, isDark, isMobile),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDark, bool isMobile) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _OverviewCard(
              icon: Icons.info_outline_rounded,
              title: 'What It Is',
              content: data.overviewWhat,
              isDark: isDark, isMobile: isMobile,
            )),
            SizedBox(width: 24),
            Expanded(child: _OverviewCard(
              icon: Icons.priority_high_rounded,
              title: 'The Problem',
              content: data.overviewProblem,
              isDark: isDark, isMobile: isMobile,
            )),
          ],
        ),
        SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _OverviewCard(
              icon: Icons.people_outline_rounded,
              title: 'Target Users',
              content: data.overviewTargetUsers,
              isDark: isDark, isMobile: isMobile,
            )),
            SizedBox(width: 24),
            Expanded(child: _OverviewCard(
              icon: Icons.heart_broken_rounded,
              title: 'Why It Matters',
              content: data.overviewWhyMatters,
              isDark: isDark, isMobile: isMobile,
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDark, bool isMobile) {
    return Column(
      children: [
        _OverviewCard(icon: Icons.info_outline_rounded, title: 'What It Is',
            content: data.overviewWhat, isDark: isDark, isMobile: isMobile),
        SizedBox(height: 12),
        _OverviewCard(icon: Icons.priority_high_rounded, title: 'The Problem',
            content: data.overviewProblem, isDark: isDark, isMobile: isMobile),
        SizedBox(height: 12),
        _OverviewCard(icon: Icons.people_outline_rounded, title: 'Target Users',
            content: data.overviewTargetUsers, isDark: isDark, isMobile: isMobile),
        SizedBox(height: 12),
        _OverviewCard(icon: Icons.heart_broken_rounded, title: 'Why It Matters',
            content: data.overviewWhyMatters, isDark: isDark, isMobile: isMobile),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final IconData icon;
  final String title, content;
  final bool isDark;
  final bool isMobile;
  const _OverviewCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = isMobile ? 36.0 : 40.0;
    final iconInnerSize = isMobile ? 18.0 : 20.0;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(icon, color: AppColors.primary, size: iconInnerSize)),
          SizedBox(height: isMobile ? 10 : 12),
          Text(title, style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              fontWeight: FontWeight.w600)),
          SizedBox(height: isMobile ? 6 : 8),
          Text(content, style: TextStyle(
              fontSize: isMobile ? 13 : 15,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              height: 1.7)),
        ],
      ),
    );
  }
}

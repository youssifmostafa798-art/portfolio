import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ProjectOverviewSection extends StatelessWidget {
  final ProjectData data;
  const ProjectOverviewSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isDark = context.isDark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Project Overview',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          SizedBox(height: 8.h),
          Text(data.overviewSubtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          SizedBox(height: 48.h),
          if (isMobile)
            _buildMobileLayout(context, isDark)
          else
            _buildDesktopLayout(context, isDark),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDark) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _OverviewCard(
              icon: Icons.info_outline_rounded,
              title: 'What It Is',
              content: data.overviewWhat,
              isDark: isDark,
            )),
            SizedBox(width: 24.w),
            Expanded(child: _OverviewCard(
              icon: Icons.priority_high_rounded,
              title: 'The Problem',
              content: data.overviewProblem,
              isDark: isDark,
            )),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _OverviewCard(
              icon: Icons.people_outline_rounded,
              title: 'Target Users',
              content: data.overviewTargetUsers,
              isDark: isDark,
            )),
            SizedBox(width: 24.w),
            Expanded(child: _OverviewCard(
              icon: Icons.heart_broken_rounded,
              title: 'Why It Matters',
              content: data.overviewWhyMatters,
              isDark: isDark,
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDark) {
    return Column(
      children: [
        _OverviewCard(icon: Icons.info_outline_rounded, title: 'What It Is',
            content: data.overviewWhat, isDark: isDark),
        SizedBox(height: 16.h),
        _OverviewCard(icon: Icons.priority_high_rounded, title: 'The Problem',
            content: data.overviewProblem, isDark: isDark),
        SizedBox(height: 16.h),
        _OverviewCard(icon: Icons.people_outline_rounded, title: 'Target Users',
            content: data.overviewTargetUsers, isDark: isDark),
        SizedBox(height: 16.h),
        _OverviewCard(icon: Icons.heart_broken_rounded, title: 'Why It Matters',
            content: data.overviewWhyMatters, isDark: isDark),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final IconData icon; final String title, content; final bool isDark;
  const _OverviewCard({
    required this.icon, required this.title, required this.content, required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 40.r, height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20.r)),
          SizedBox(height: 12.h),
          Text(title, style: AppTypography.textTheme.titleMedium?.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          Text(content, style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              height: 1.7)),
        ],
      ),
    );
  }
}

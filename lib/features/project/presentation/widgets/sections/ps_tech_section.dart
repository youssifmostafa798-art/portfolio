import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class TechSection extends StatelessWidget {
  final ProjectData data;
  const TechSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final crossAxisCount = responsive.crossAxisCount;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tech Stack',
              style: context.textTheme.displaySmall?.copyWith(
                  color: responsive.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          SizedBox(height: 8.h),
          Text(data.techStackSubtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                  color: responsive.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          SizedBox(height: 48.h),
          _ResponsiveGrid(
            crossAxisCount: crossAxisCount,
            isDark: responsive.isDark,
            children: data.techCategories.map((t) => _TechCategoryCard(cat: t, isDark: responsive.isDark)).toList(),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  final int crossAxisCount;
  final bool isDark;
  final List<Widget> children;

  const _ResponsiveGrid({
    required this.crossAxisCount,
    required this.isDark,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = 16.w;
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: children.map((child) => SizedBox(
        width: (MediaQuery.of(context).size.width -
            context.responsive.responsivePadding * 2 -
            spacing * (crossAxisCount - 1)) / crossAxisCount,
        child: child,
      )).toList(),
    );
  }
}

class _TechCategoryCard extends StatelessWidget {
  final TechCategory cat;
  final bool isDark;
  const _TechCategoryCard({required this.cat, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(cat.category,
              style: AppTypography.textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          Text(cat.items,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
        ],
      ),
    );
  }
}

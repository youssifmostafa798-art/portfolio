import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class PerformanceSection extends StatelessWidget {
  const PerformanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final isDark = context.isDark;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: AppSpacing.sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Performance Optimizations',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('Techniques used to ensure smooth, responsive, and efficient operation.',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          const SizedBox(height: AppSpacing.xxxl),
          LayoutBuilder(builder: (context, constraints) {
            final spacing = AppSpacing.lg;
            final childWidth =
                (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: vitaguardPerformance.map((p) => SizedBox(
                width: childWidth,
                child: _PerfCard(item: p, isDark: isDark),
              )).toList(),
            );
          }),
        ],
      ),
    );
  }
}

class _PerfCard extends StatelessWidget {
  final PerformanceItem item;
  final bool isDark;
  const _PerfCard({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(item.title,
              style: AppTypography.textTheme.titleSmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: Text(item.description,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    height: 1.6)),
          ),
        ],
      ),
    );
  }
}

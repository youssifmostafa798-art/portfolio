import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class FutureSection extends StatelessWidget {
  const FutureSection({super.key});

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
          Text('Future Improvements',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('Planned enhancements and roadmap for the project.',
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
              children: vitaguardFuture.map((f) => SizedBox(
                width: childWidth,
                child: _FutureCard(item: f, isDark: isDark),
              )).toList(),
            );
          }),
        ],
      ),
    );
  }
}

class _FutureCard extends StatelessWidget {
  final FutureItem item;
  final bool isDark;
  const _FutureCard({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
                child: Icon(item.icon, color: AppColors.primary, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.warning.withValues(alpha: 0.1),
                ),
                child: Text('Planned',
                    style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: AppColors.warning, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(item.title,
              style: AppTypography.textTheme.titleSmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.xs),
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

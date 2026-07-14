import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class ContributionSection extends StatelessWidget {
  const ContributionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: AppSpacing.sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Contribution',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('As the Flutter Mobile Application Developer on a 12-person team.',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          const SizedBox(height: AppSpacing.xxxl),
          ...List.generate(VitaguardData.contributions.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: GlassCard(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.1),
                      ),
                      child: Center(
                        child: Text('${i + 1}',
                            style: AppTypography.textTheme.labelMedium?.copyWith(
                                color: AppColors.primary, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(VitaguardData.contributions[i],
                          style: AppTypography.textTheme.bodyMedium?.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              height: 1.7)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

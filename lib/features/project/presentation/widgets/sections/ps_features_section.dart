import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

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
          Text('Features',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('Key capabilities that make VitaGuard a production-grade medical system.',
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
              children: vitaguardFeatures.map((f) => SizedBox(
                width: childWidth,
                child: _FeatureCard(feature: f, isDark: isDark),
              )).toList(),
            );
          }),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final FeatureItem feature;
  final bool isDark;
  const _FeatureCard({required this.feature, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
            ),
            child: Icon(feature.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(feature.title,
              style: AppTypography.textTheme.titleSmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: Text(feature.description,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    height: 1.6)),
          ),
        ],
      ),
    );
  }
}

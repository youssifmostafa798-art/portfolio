import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class ArchitectureSection extends StatelessWidget {
  const ArchitectureSection({super.key});

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
          Text('Architecture',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('The four-layer architecture powering the system.',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          const SizedBox(height: AppSpacing.xxxl),
          Column(
            children: List.generate(vitaguardArchitecture.length, (i) {
              final layer = vitaguardArchitecture[i];
              final isLast = i == vitaguardArchitecture.length - 1;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LayerCard(layer: layer, index: i, isDark: isDark),
                  if (!isLast) _ArrowDown(isDark: isDark),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _LayerCard extends StatelessWidget {
  final ArchitectureLayer layer;
  final int index;
  final bool isDark;
  const _LayerCard({required this.layer, required this.index, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      const Color(0xFF32D74B),
      const Color(0xFFFF9500),
      const Color(0xFFFF3B30),
    ];

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border.all(
          color: isDark ? AppColors.darkDivider.withValues(alpha: 0.5) : AppColors.lightDivider.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4, height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: colors[index % colors.length],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(layer.layer,
                    style: AppTypography.textTheme.titleSmall?.copyWith(
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(layer.detail,
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
              ],
            ),
          ),
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors[index % colors.length].withValues(alpha: 0.1),
            ),
            child: Center(
              child: Text('${index + 1}',
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                      color: colors[index % colors.length],
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowDown extends StatelessWidget {
  final bool isDark;
  const _ArrowDown({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward_rounded, size: 20,
          color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight),
    );
  }
}

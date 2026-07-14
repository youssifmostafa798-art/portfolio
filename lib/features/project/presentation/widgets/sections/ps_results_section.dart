import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class ResultsSection extends StatelessWidget {
  const ResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
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
          Text('Results',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('Outcomes and achievements from the VitaGuard project.',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          const SizedBox(height: AppSpacing.xxxl),
          if (isMobile)
            Column(
              children: vitaguardResults.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _ResultCard(text: r, isDark: isDark),
              )).toList(),
            )
          else
            ...List.generate((vitaguardResults.length / 2).ceil(), (rowIndex) {
              final start = rowIndex * 2;
              final end = (start + 2).clamp(0, vitaguardResults.length);
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Row(
                  children: vitaguardResults.sublist(start, end).map((r) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: rowIndex > 0 || start > 0 ? AppSpacing.sm : 0,
                        right: rowIndex > 0 || end < vitaguardResults.length ? AppSpacing.sm : 0,
                      ),
                      child: _ResultCard(text: r, isDark: isDark),
                    ),
                  )).toList(),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String text;
  final bool isDark;
  const _ResultCard({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 20, height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withValues(alpha: 0.1),
            ),
            child: const Icon(Icons.check_rounded, size: 12, color: AppColors.success),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(text,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    height: 1.5)),
          ),
        ],
      ),
    );
  }
}

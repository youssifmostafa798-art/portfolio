import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class ChallengesSection extends StatelessWidget {
  const ChallengesSection({super.key});

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
          Text('Challenges',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('Major technical challenges and how they were solved.',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          const SizedBox(height: AppSpacing.xxxl),
          ...vitaguardChallenges.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xl),
            child: _ChallengeCard(challenge: c, isDark: isDark),
          )),
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final ChallengeItem challenge;
  final bool isDark;
  const _ChallengeCard({required this.challenge, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(challenge.title,
              style: AppTypography.textTheme.titleMedium?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          _Label(text: 'Problem', isDark: isDark),
          const SizedBox(height: AppSpacing.xs),
          Text(challenge.problem,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  height: 1.7)),
          const SizedBox(height: AppSpacing.md),
          _Label(text: 'Solution', isDark: isDark),
          const SizedBox(height: AppSpacing.xs),
          Text(challenge.solution,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  height: 1.7)),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text; final bool isDark;
  const _Label({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Text(text,
          style: AppTypography.textTheme.labelSmall?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600)),
    );
  }
}

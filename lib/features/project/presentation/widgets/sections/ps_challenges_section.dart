import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ChallengesSection extends StatelessWidget {
  final ProjectData data;
  const ChallengesSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
          Text('Challenges',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          SizedBox(height: 8.h),
          Text(data.challengesSubtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          SizedBox(height: 48.h),
          ...data.challenges.map((c) => Padding(
            padding: EdgeInsets.only(bottom: 24.h),
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
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(challenge.title,
              style: AppTypography.textTheme.titleMedium?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 12.h),
          _Label(text: 'Problem', isDark: isDark),
          SizedBox(height: 4.h),
          Text(challenge.problem,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  height: 1.7)),
          SizedBox(height: 12.h),
          _Label(text: 'Solution', isDark: isDark),
          SizedBox(height: 4.h),
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Text(text,
          style: AppTypography.textTheme.labelSmall?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ContributionSection extends StatelessWidget {
  final ProjectData data;
  const ContributionSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDark = responsive.isDark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Contribution',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          SizedBox(height: 8.h),
          Text(data.contributionSubtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          SizedBox(height: 48.h),
          ...List.generate(data.contributions.length, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GlassCard(
                padding: EdgeInsets.all(24.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32.r, height: 32.r,
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
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(data.contributions[i],
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

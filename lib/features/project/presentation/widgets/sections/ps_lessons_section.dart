import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class LessonsSection extends StatelessWidget {
  final ProjectData data;
  const LessonsSection({super.key, required this.data});

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
          Text('Lessons Learned',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          SizedBox(height: 8.h),
          Text(data.lessonsSubtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          SizedBox(height: 48.h),
          ...data.lessons.map((l) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: GlassCard(
              padding: EdgeInsets.all(24.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4.h),
                    width: 8.r, height: 8.r,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(l,
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            height: 1.7)),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

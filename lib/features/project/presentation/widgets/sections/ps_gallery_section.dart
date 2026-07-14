import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/utils/url_utils.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

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
        vertical: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gallery',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          SizedBox(height: 8.h),
          Text('Screenshots and visuals from the application.',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          SizedBox(height: 48.h),
          LayoutBuilder(builder: (context, constraints) {
            final spacing = 16.w;
            final childWidth =
                (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: List.generate(4, (i) => SizedBox(
                width: childWidth,
                child: _GalleryCard(index: i, isDark: isDark),
              )),
            );
          }),
          SizedBox(height: 24.h),
          Center(
            child: Semantics(
              button: true,
              label: 'View all screenshots on Google Drive',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => UrlUtils.openUrl(VitaguardData.screenshotsUrl),
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_library_rounded, size: 18.r, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text('View All Screenshots on Google Drive',
                          style: AppTypography.textTheme.labelLarge?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final int index;
  final bool isDark;
  const _GalleryCard({required this.index, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screens = ['Patient Dashboard', 'Health Monitoring', 'AI X-Ray Analysis', 'Alert Center'];
    final colors = [
      const Color(0xFF0D1B2A),
      const Color(0xFF1A1A2E),
      const Color(0xFF16213E),
      const Color(0xFF0F3460),
    ];

    return Semantics(
      button: true,
      label: 'View ${screens[index]} screenshot',
      child: GestureDetector(
        onTap: () => UrlUtils.openUrl(VitaguardData.screenshotsUrl),
        child: GlassCard(
          padding: EdgeInsets.zero,
          child: Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                colors: [colors[index], colors[index].withValues(alpha: 0.7)],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone_android_rounded, size: 48.r,
                          color: Colors.white.withValues(alpha: 0.3)),
                      SizedBox(height: 8.h),
                      Text(screens[index],
                          style: AppTypography.textTheme.titleSmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
                Positioned(
                  top: 12.h, right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: Text('Screenshot ${index + 1}',
                        style: AppTypography.textTheme.labelSmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.6))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
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
        vertical: AppSpacing.sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gallery',
              style: context.textTheme.displaySmall?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: AppSpacing.sm),
          Text('Screenshots and visuals from the application.',
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
              children: List.generate(4, (i) => SizedBox(
                width: childWidth,
                child: _GalleryCard(index: i, isDark: isDark),
              )),
            );
          }),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Semantics(
              button: true,
              label: 'View all screenshots on Google Drive',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => UrlUtils.openUrl(VitaguardData.screenshotsUrl),
                  child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_library_rounded, size: 18, color: Colors.white),
                      const SizedBox(width: 8),
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
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
                      Icon(Icons.phone_android_rounded, size: 48,
                          color: Colors.white.withValues(alpha: 0.3)),
                      const SizedBox(height: 8),
                      Text(screens[index],
                          style: AppTypography.textTheme.titleSmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
                Positioned(
                  top: 12, right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
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

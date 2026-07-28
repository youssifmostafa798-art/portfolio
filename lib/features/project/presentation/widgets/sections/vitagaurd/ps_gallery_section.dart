import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/url_utils.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class GallerySection extends StatelessWidget {
  final ProjectData data;
  const GallerySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isMobile = responsive.isMobile;
    final sectionVertical = context.responsiveSectionVertical;
    final sectionGap = context.responsiveSectionGap;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gallery',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: responsive.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.gallerySubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: responsive.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          _ResponsiveGrid(
            isMobile: isMobile,
            isDark: responsive.isDark,
            children: List.generate(data.screenshotLabels.length, (i) =>
                _GalleryCard(
                  index: i,
                  label: data.screenshotLabels[i],
                  color: data.screenshotColors[i],
                  screenshotsUrl: data.screenshotsUrl,
                  isDark: responsive.isDark,
                  isMobile: isMobile,
                )),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          Center(
            child: Semantics(
              button: true,
              label: 'View all screenshots on Google Drive',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => UrlUtils.openUrl(data.screenshotsUrl),
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 24, vertical: isMobile ? 10 : 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.responsiveBorderRadius),
                    color: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_library_rounded, size: isMobile ? 16 : 18, color: Colors.white),
                      SizedBox(width: isMobile ? 6 : 8),
                      Text('View All Screenshots on Google Drive',
                          style: TextStyle(
                              fontSize: isMobile ? 12 : 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
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

class _ResponsiveGrid extends StatelessWidget {
  final bool isMobile;
  final bool isDark;
  final List<Widget> children;

  const _ResponsiveGrid({
    required this.isMobile,
    required this.isDark,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = isMobile ? 10.0 : 16.0;
    final crossAxisCount = isMobile ? 1 : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final childWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children.map((child) => SizedBox(
            width: childWidth,
            child: child,
          )).toList(),
        );
      },
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final int index;
  final String label;
  final Color color;
  final String screenshotsUrl;
  final bool isDark;
  final bool isMobile;
  const _GalleryCard({
    required this.index,
    required this.label,
    required this.color,
    required this.screenshotsUrl,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = isMobile ? 180.0 : 200.0;

    return Semantics(
      button: true,
      label: 'View $label screenshot',
      child: GestureDetector(
        onTap: () => UrlUtils.openUrl(screenshotsUrl),
        child: GlassCard(
          padding: EdgeInsets.zero,
          child: Container(
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.responsiveBorderRadius),
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.7)],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone_android_rounded, size: isMobile ? 40 : 48,
                          color: Colors.white.withValues(alpha: 0.3)),
                      SizedBox(height: isMobile ? 6 : 8),
                      Text(label,
                          style: TextStyle(
                              fontSize: isMobile ? 13 : 14,
                              color: Colors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
                Positioned(
                  top: isMobile ? 10 : 12,
                  right: isMobile ? 10 : 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 8, vertical: isMobile ? 3 : 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: Text('Screenshot ${index + 1}',
                        style: TextStyle(
                            fontSize: isMobile ? 10 : 11,
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

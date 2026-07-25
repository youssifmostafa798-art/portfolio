import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class FutureSection extends StatelessWidget {
  final ProjectData data;
  const FutureSection({super.key, required this.data});

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
          Text('Future Improvements',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: responsive.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.futureSubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: responsive.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          _ResponsiveGrid(
            isMobile: isMobile,
            isDark: responsive.isDark,
            children: data.futureItems.map((f) => _FutureCard(item: f, isDark: responsive.isDark, isMobile: isMobile)).toList(),
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

class _FutureCard extends StatelessWidget {
  final FutureItem item;
  final bool isDark;
  final bool isMobile;
  const _FutureCard({required this.item, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final iconContainerSize = isMobile ? 32.0 : 36.0;
    final iconSize = isMobile ? 18.0 : 20.0;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 14 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: iconContainerSize, height: iconContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
                child: Icon(item.icon, color: AppColors.primary, size: iconSize),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 8, vertical: isMobile ? 2 : 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.warning.withValues(alpha: 0.1),
                ),
                child: Text('Planned',
                    style: TextStyle(
                        fontSize: isMobile ? 10 : 11,
                        color: AppColors.warning,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 10 : 12),
          Text(item.title,
              style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: isMobile ? 3 : 4),
          Flexible(
            child: Text(item.description,
                style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    height: 1.6)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ArchitectureSection extends StatelessWidget {
  final ProjectData data;
  const ArchitectureSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDark = responsive.isDark;
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
          Text('Architecture',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.architectureSubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          Column(
            children: List.generate(data.architecture.length, (i) {
              final layer = data.architecture[i];
              final isLast = i == data.architecture.length - 1;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LayerCard(layer: layer, index: i, isDark: isDark, isMobile: isMobile),
                  if (!isLast) _ArrowDown(isDark: isDark, isMobile: isMobile),
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
  final bool isMobile;
  const _LayerCard({required this.layer, required this.index, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      const Color(0xFF32D74B),
      const Color(0xFFFF9500),
      const Color(0xFFFF3B30),
    ];

    final cardPadding = isMobile ? 16.0 : 24.0;
    final barWidth = isMobile ? 3.0 : 4.0;
    final barHeight = isMobile ? 40.0 : 48.0;
    final badgeSize = isMobile ? 28.0 : 32.0;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 600),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.responsiveBorderRadius),
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border.all(
          color: isDark ? AppColors.darkDivider.withValues(alpha: 0.5) : AppColors.lightDivider.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: barWidth, height: barHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: colors[index % colors.length],
            ),
          ),
          SizedBox(width: isMobile ? 10 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(layer.layer,
                    style: TextStyle(
                        fontSize: isMobile ? 13 : 14,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: isMobile ? 3 : 4),
                Text(layer.detail,
                    style: TextStyle(
                        fontSize: isMobile ? 12 : 13,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
              ],
            ),
          ),
          Container(
            width: badgeSize, height: badgeSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors[index % colors.length].withValues(alpha: 0.1),
            ),
            child: Center(
              child: Text('${index + 1}',
                  style: TextStyle(
                      fontSize: isMobile ? 10 : 11,
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
  final bool isMobile;
  const _ArrowDown({required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 3 : 4),
      child: Icon(Icons.arrow_downward_rounded, size: isMobile ? 18 : 20,
          color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight),
    );
  }
}

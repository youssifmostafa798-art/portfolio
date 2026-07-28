import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class FeaturesSection extends StatelessWidget {
  final ProjectData data;
  const FeaturesSection({super.key, required this.data});

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
          Text('Features',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: responsive.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.featuresSubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: responsive.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          _ResponsiveGrid(
            isMobile: isMobile,
            isDark: responsive.isDark,
            children: data.features.map((f) => _FeatureCard(feature: f, isDark: responsive.isDark, isMobile: isMobile)).toList(),
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

class _FeatureCard extends StatelessWidget {
  final FeatureItem feature;
  final bool isDark;
  final bool isMobile;
  const _FeatureCard({required this.feature, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final iconContainerSize = isMobile ? 40.0 : 44.0;
    final iconSize = isMobile ? 20.0 : 22.0;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 18 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
            ),
            child: Icon(feature.icon, color: Colors.white, size: iconSize),
          ),
          SizedBox(height: isMobile ? 10 : 12),
          Text(feature.title,
              style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: isMobile ? 6 : 8),
          Flexible(
            child: Text(feature.description,
                style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    height: 1.6)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/maxfashion/data/maxfashion_data.dart';
import 'maxfashion_colors.dart';

class MaxfashionTextSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String body;
  const MaxfashionTextSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.body,
  });

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
          Text(title,
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              )),
          if (subtitle != null) ...[
            SizedBox(height: isMobile ? 6 : 8),
            Text(subtitle!,
                style: TextStyle(
                  fontSize: context.responsiveSubtitleSize,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                )),
          ],
          SizedBox(height: sectionGap),
          GlassCard(
            padding: EdgeInsets.all(isMobile ? 18 : 24),
            child: Text(body,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  height: 1.7,
                )),
          ),
        ],
      ),
    );
  }
}

class MaxfashionCardGridSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<MaxfashionFeature> items;
  const MaxfashionCardGridSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
  });

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
          Text(title,
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              )),
          if (subtitle != null) ...[
            SizedBox(height: isMobile ? 6 : 8),
            Text(subtitle!,
                style: TextStyle(
                  fontSize: context.responsiveSubtitleSize,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                )),
          ],
          SizedBox(height: sectionGap),
          _ResponsiveCardGrid(
            isMobile: isMobile,
            isDark: isDark,
            items: items,
          ),
        ],
      ),
    );
  }
}

class _ResponsiveCardGrid extends StatelessWidget {
  final bool isMobile;
  final bool isDark;
  final List<MaxfashionFeature> items;
  const _ResponsiveCardGrid({
    required this.isMobile,
    required this.isDark,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = isMobile ? 10.0 : 16.0;
    final crossAxisCount = isMobile ? 1 : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final childWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map((item) => SizedBox(
                    width: childWidth,
                    child: _FeatureCard(
                        item: item, isDark: isDark, isMobile: isMobile),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final MaxfashionFeature item;
  final bool isDark;
  final bool isMobile;
  const _FeatureCard({
    required this.item,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            Container(
              width: isMobile ? 36 : 40,
              height: isMobile ? 36 : 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                gradient: const LinearGradient(
                  colors: [MaxfashionColors.primaryBlack, MaxfashionColors.darkBorder],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child:
                  Icon(item.icon, color: Colors.white, size: isMobile ? 18 : 20),
            ),
            SizedBox(height: isMobile ? 10 : 12),
          ],
          Text(item.title,
              style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: isMobile ? 6 : 8),
          Flexible(
            child: Text(item.description,
                style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    height: 1.6)),
          ),
        ],
      ),
    );
  }
}

class MaxfashionMetricsSection extends StatelessWidget {
  final String title;
  final List<MaxfashionMetric> items;
  const MaxfashionMetricsSection({required this.title, required this.items, super.key});

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
          Text(title,
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              )),
          SizedBox(height: sectionGap),
          Wrap(
            spacing: isMobile ? 10 : 16,
            runSpacing: isMobile ? 10 : 16,
            children: items.map((metric) {
              return SizedBox(
                width: isMobile
                    ? (MediaQuery.of(context).size.width - 64) / 2
                    : 180,
                child: GlassCard(
                  padding: EdgeInsets.all(isMobile ? 14 : 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(metric.value,
                          style: TextStyle(
                            fontSize: isMobile ? 22 : 28,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? MaxfashionColors.primaryWhite
                                : MaxfashionColors.primaryBlack,
                          )),
                      SizedBox(height: isMobile ? 4 : 6),
                      Text(metric.label,
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 13,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class MaxfashionProblemSolutionSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<MaxfashionChallenge> items;
  const MaxfashionProblemSolutionSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
  });

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
          Text(title,
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              )),
          if (subtitle != null) ...[
            SizedBox(height: isMobile ? 6 : 8),
            Text(subtitle!,
                style: TextStyle(
                  fontSize: context.responsiveSubtitleSize,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                )),
          ],
          SizedBox(height: sectionGap),
          ...items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 14 : 20),
                child: GlassCard(
                  padding: EdgeInsets.all(isMobile ? 18 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title,
                          style: TextStyle(
                            fontSize: isMobile ? 15 : 16,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(height: isMobile ? 12 : 16),
                      _ChallengeLabel(
                          text: 'Challenge',
                          isDark: isDark,
                          isMobile: isMobile),
                      SizedBox(height: 6),
                      Text(item.problem,
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 14,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            height: 1.7,
                          )),
                      SizedBox(height: isMobile ? 12 : 16),
                      _ChallengeLabel(
                          text: 'Solution',
                          isDark: isDark,
                          isMobile: isMobile),
                      SizedBox(height: 6),
                      Text(item.solution,
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 14,
                            color: isDark
                                ? MaxfashionColors.primaryWhite
                                : MaxfashionColors.primaryBlack,
                            height: 1.7,
                          )),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _ChallengeLabel extends StatelessWidget {
  final String text;
  final bool isDark;
  final bool isMobile;
  const _ChallengeLabel({
    required this.text,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 10, vertical: isMobile ? 3 : 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Text(text,
          style: TextStyle(
            fontSize: isMobile ? 11 : 12,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}

class MaxfashionBulletListSection extends StatelessWidget {
  final String title;
  final List<String> items;
  const MaxfashionBulletListSection({
    super.key,
    required this.title,
    required this.items,
  });

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
          Text(title,
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              )),
          SizedBox(height: sectionGap),
          ...items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 8 : 10),
                child: GlassCard(
                  padding: EdgeInsets.all(isMobile ? 14 : 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: isMobile ? 5 : 6),
                        width: isMobile ? 7 : 8,
                        height: isMobile ? 7 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? MaxfashionColors.primaryWhite
                              : MaxfashionColors.primaryBlack,
                        ),
                      ),
                      SizedBox(width: isMobile ? 10 : 12),
                      Expanded(
                        child: Text(item,
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 14,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              height: 1.6,
                            )),
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

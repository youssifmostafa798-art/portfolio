import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/hungryy_data.dart';
import 'hungryy_colors.dart';

class HungryyTextSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String body;
  final List<String>? bulletPoints;
  const HungryyTextSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.body,
    this.bulletPoints,
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
          if (bulletPoints != null && bulletPoints!.isNotEmpty) ...[
            SizedBox(height: isMobile ? 12 : 16),
            ...bulletPoints!.map((point) => Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 8 : 10),
                  child: GlassCard(
                    padding: EdgeInsets.all(isMobile ? 14 : 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: isMobile ? 5 : 6),
                          width: isMobile ? 6 : 7,
                          height: isMobile ? 6 : 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: HungryyColors.primary,
                          ),
                        ),
                        SizedBox(width: isMobile ? 10 : 12),
                        Expanded(
                          child: Text(point,
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
        ],
      ),
    );
  }
}

class HungryyCardGridSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<HungryyCardItem> cards;
  final int crossAxisCount;
  const HungryyCardGridSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.cards,
    this.crossAxisCount = 2,
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
            crossAxisCount: isMobile ? 1 : crossAxisCount,
            cards: cards,
          ),
        ],
      ),
    );
  }
}

class _ResponsiveCardGrid extends StatelessWidget {
  final bool isMobile;
  final bool isDark;
  final int crossAxisCount;
  final List<HungryyCardItem> cards;

  const _ResponsiveCardGrid({
    required this.isMobile,
    required this.isDark,
    required this.crossAxisCount,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = isMobile ? 10.0 : 16.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final childWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards
              .map((card) => SizedBox(
                    width: childWidth,
                    child: _ContentCard(
                        card: card, isDark: isDark, isMobile: isMobile),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _ContentCard extends StatelessWidget {
  final HungryyCardItem card;
  final bool isDark;
  final bool isMobile;
  const _ContentCard(
      {required this.card, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (card.icon != null) ...[
            Container(
              width: isMobile ? 36 : 40,
              height: isMobile ? 36 : 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                gradient: const LinearGradient(
                  colors: [HungryyColors.primary, HungryyColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(card.icon, color: Colors.white, size: isMobile ? 18 : 20),
            ),
            SizedBox(height: isMobile ? 10 : 12),
          ],
          Text(card.title,
              style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: isMobile ? 6 : 8),
          Flexible(
            child: Text(card.description,
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

class HungryyProblemSolutionSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<HungryyProblemSolution> items;
  const HungryyProblemSolutionSection({
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
                      _ProblemLabel(text: 'Problem', isDark: isDark, isMobile: isMobile),
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
                      _ProblemLabel(text: 'Solution', isDark: isDark, isMobile: isMobile),
                      SizedBox(height: 6),
                      Text(item.solution,
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 14,
                            color: HungryyColors.primary,
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

class _ProblemLabel extends StatelessWidget {
  final String text;
  final bool isDark;
  final bool isMobile;
  const _ProblemLabel(
      {required this.text, required this.isDark, required this.isMobile});

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

class HungryyBulletListSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String> items;
  const HungryyBulletListSection({
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: HungryyColors.primary,
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

class HungryyImagePlaceholdersSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<HungryyPlaceholderItem> items;
  const HungryyImagePlaceholdersSection({
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
          _PlaceholderGrid(
            isMobile: isMobile,
            isDark: isDark,
            items: items,
          ),
        ],
      ),
    );
  }
}

class _PlaceholderGrid extends StatelessWidget {
  final bool isMobile;
  final bool isDark;
  final List<HungryyPlaceholderItem> items;
  const _PlaceholderGrid(
      {required this.isMobile, required this.isDark, required this.items});

  @override
  Widget build(BuildContext context) {
    final spacing = isMobile ? 10.0 : 16.0;
    final crossAxisCount = isMobile ? 2 : 3;

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
                    child: _PlaceholderCard(
                        item: item, isDark: isDark, isMobile: isMobile),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  final HungryyPlaceholderItem item;
  final bool isDark;
  final bool isMobile;
  const _PlaceholderCard(
      {required this.item, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final cardHeight = isMobile ? 140.0 : 160.0;

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.responsiveBorderRadius),
          gradient: LinearGradient(
            colors: [item.color, item.color.withValues(alpha: 0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_android_rounded,
                      size: isMobile ? 32 : 40,
                      color: Colors.white.withValues(alpha: 0.3)),
                  SizedBox(height: isMobile ? 6 : 8),
                  Text(item.label,
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 13,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 4),
                  Text('Placeholder',
                      style: TextStyle(
                        fontSize: isMobile ? 10 : 11,
                        color: Colors.white.withValues(alpha: 0.5),
                      )),
                ],
              ),
            ),
            Positioned(
              top: isMobile ? 8 : 10,
              right: isMobile ? 8 : 10,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 6 : 8, vertical: isMobile ? 2 : 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Text('Replace with screenshot',
                    style: TextStyle(
                      fontSize: isMobile ? 9 : 10,
                      color: Colors.white.withValues(alpha: 0.6),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

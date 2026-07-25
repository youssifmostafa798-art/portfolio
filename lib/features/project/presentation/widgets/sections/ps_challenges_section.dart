import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ChallengesSection extends StatelessWidget {
  final ProjectData data;
  const ChallengesSection({super.key, required this.data});

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
          Text('Challenges',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.challengesSubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          ...data.challenges.map((c) => Padding(
            padding: EdgeInsets.only(bottom: isMobile ? 16 : 24),
            child: _ChallengeCard(challenge: c, isDark: isDark, isMobile: isMobile),
          )),
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final ChallengeItem challenge;
  final bool isDark;
  final bool isMobile;
  const _ChallengeCard({required this.challenge, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 18 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(challenge.title,
              style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: isMobile ? 10 : 12),
          _Label(text: 'Problem', isDark: isDark, isMobile: isMobile),
          SizedBox(height: 4),
          Text(challenge.problem,
              style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  height: 1.7)),
          SizedBox(height: isMobile ? 10 : 12),
          _Label(text: 'Solution', isDark: isDark, isMobile: isMobile),
          SizedBox(height: 4),
          Text(challenge.solution,
              style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  color: AppColors.primary,
                  height: 1.7)),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  final bool isDark;
  final bool isMobile;
  const _Label({required this.text, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 8, vertical: isMobile ? 2 : 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: isMobile ? 10 : 11,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600)),
    );
  }
}

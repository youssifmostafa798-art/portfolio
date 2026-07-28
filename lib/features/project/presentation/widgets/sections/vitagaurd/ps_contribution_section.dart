import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ContributionSection extends StatelessWidget {
  final ProjectData data;
  const ContributionSection({super.key, required this.data});

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
          Text('My Contribution',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.contributionSubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          ...List.generate(data.contributions.length, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 10 : 16),
              child: GlassCard(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: isMobile ? 28 : 32,
                      height: isMobile ? 28 : 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.1),
                      ),
                      child: Center(
                        child: Text('${i + 1}',
                            style: TextStyle(
                                fontSize: isMobile ? 11 : 13,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(width: isMobile ? 10 : 12),
                    Expanded(
                      child: Text(data.contributions[i],
                          style: TextStyle(
                              fontSize: isMobile ? 13 : 14,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              height: 1.7)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

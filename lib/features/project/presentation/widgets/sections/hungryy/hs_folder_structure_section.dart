import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/hungryy_data.dart';
import 'hungryy_colors.dart';

class HungryyFolderStructureSection extends StatelessWidget {
  final HungryyData data;
  const HungryyFolderStructureSection({super.key, required this.data});

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
          Text('Folder Structure',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text('Feature-based organization for scalable code management.',
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          GlassCard(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.folderStructureItems
                  .map((item) => Padding(
                        padding:
                            EdgeInsets.only(bottom: isMobile ? 10 : 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: isMobile ? 6 : 8,
                              height: isMobile ? 6 : 8,
                              margin:
                                  EdgeInsets.only(top: isMobile ? 5 : 6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: HungryyColors.primary,
                              ),
                            ),
                            SizedBox(width: isMobile ? 10 : 12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: item.title,
                                      style: TextStyle(
                                        fontSize: isMobile ? 13 : 14,
                                        color: HungryyColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' — ${item.description}',
                                      style: TextStyle(
                                        fontSize: isMobile ? 13 : 14,
                                        color: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/maxfashion/data/maxfashion_data.dart';
import 'maxfashion_colors.dart';

class MaxfashionArchitectureSection extends StatelessWidget {
  final MaxfashionData data;
  const MaxfashionArchitectureSection({super.key, required this.data});

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
          Text('Supabase Architecture',
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
          Text('Layered architecture from Flutter client to Supabase backend.',
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          ...data.architectureLayers.asMap().entries.map((entry) {
            final index = entry.key;
            final layer = entry.value;
            final isLast = index == data.architectureLayers.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : (isMobile ? 12 : 16)),
              child: GlassCard(
                padding: EdgeInsets.all(isMobile ? 16 : 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: isMobile ? 32 : 36,
                      height: isMobile ? 32 : 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isDark
                            ? MaxfashionColors.darkBorder.withValues(alpha: 0.15)
                            : MaxfashionColors.secondaryTextLight.withValues(alpha: 0.15),
                      ),
                      child: Center(
                        child: Text('${index + 1}',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? MaxfashionColors.primaryWhite
                                  : MaxfashionColors.primaryBlack,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                    SizedBox(width: isMobile ? 12 : 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(layer.name,
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 15,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              )),
                          SizedBox(height: isMobile ? 4 : 6),
                          Text(layer.detail,
                              style: TextStyle(
                                fontSize: isMobile ? 13 : 14,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                                height: 1.6,
                              )),
                        ],
                      ),
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

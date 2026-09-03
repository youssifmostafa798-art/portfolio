import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/maxfashion/data/maxfashion_data.dart';
import 'maxfashion_colors.dart';

class MaxfashionConclusionSection extends StatelessWidget {
  final MaxfashionData data;
  final VoidCallback onBackTap;
  const MaxfashionConclusionSection({super.key, required this.data, required this.onBackTap});

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
          Text('Conclusion',
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
          GlassCard(
            padding: EdgeInsets.all(isMobile ? 18 : 24),
            child: Text(data.conclusionBody,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  height: 1.7,
                )),
          ),
          SizedBox(height: sectionGap),
          Center(
            child: GestureDetector(
              onTap: onBackTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 32,
                    vertical: isMobile ? 12 : 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [MaxfashionColors.primaryBlack, MaxfashionColors.darkBorder],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text('Back to Portfolio',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 40 : 64),
        ],
      ),
    );
  }
}

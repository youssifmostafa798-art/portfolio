import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/features/project/maxfashion/data/maxfashion_data.dart';
import 'maxfashion_colors.dart';

class MaxfashionHeroSection extends StatelessWidget {
  final MaxfashionData data;
  final VoidCallback? onBackTap;
  const MaxfashionHeroSection({super.key, required this.data, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isMobile = responsive.isMobile;
    final isDark = responsive.isDark;
    final sectionGap = context.responsiveSectionGap;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: isMobile ? 40 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: isMobile ? 20 : 32),
          if (onBackTap != null)
            _BackButton(onTap: onBackTap!),
          SizedBox(height: isMobile ? 28 : 48),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 14, vertical: isMobile ? 4 : 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDark
                  ? MaxfashionColors.darkBorder.withValues(alpha: 0.15)
                  : MaxfashionColors.secondaryTextLight.withValues(alpha: 0.15),
            ),
            child: Text(data.status,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 13,
                  color: isDark
                      ? MaxfashionColors.primaryWhite
                      : MaxfashionColors.primaryBlack,
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(height: isMobile ? 14 : 24),
          Text(
            data.title,
            style: TextStyle(
              fontSize: isMobile ? 30 : 48,
              fontWeight: FontWeight.w700,
              height: 1.08,
              letterSpacing: -0.02,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            data.tagline,
            style: TextStyle(
              fontSize: isMobile ? 15 : 18,
              color: isDark
                  ? MaxfashionColors.primaryWhite
                  : MaxfashionColors.primaryBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          Text(
            data.heroDescription,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              height: 1.7,
            ),
          ),
          SizedBox(height: sectionGap),
          Wrap(
            spacing: isMobile ? 8 : 12,
            runSpacing: isMobile ? 8 : 12,
            children: [
              _InfoChip(label: 'Role', value: data.role, isDark: isDark, isMobile: isMobile),
              _InfoChip(label: 'Team', value: data.teamSize, isDark: isDark, isMobile: isMobile),
              _InfoChip(label: 'Timeline', value: data.timeline, isDark: isDark, isMobile: isMobile),
              _InfoChip(label: 'Platforms', value: data.platforms, isDark: isDark, isMobile: isMobile),
            ],
          ),
          SizedBox(height: sectionGap),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: data.techStackTop.map((tech) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 10 : 14, vertical: isMobile ? 5 : 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isDark
                      ? AppColors.darkSurface
                      : AppColors.lightSurface,
                ),
                child: Text(tech,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 13,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontWeight: FontWeight.w500,
                    )),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobile;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_rounded,
              size: isMobile ? 18 : 20,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight),
          SizedBox(width: isMobile ? 6 : 8),
          Text('Back',
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  final bool isMobile;
  const _InfoChip({
    required this.label,
    required this.value,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16, vertical: isMobile ? 8 : 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ',
              style: TextStyle(
                fontSize: isMobile ? 12 : 13,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              )),
          Text(value,
              style: TextStyle(
                fontSize: isMobile ? 12 : 13,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  final String? subtitle;

  const SectionLabel({
    super.key,
    required this.label,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final titleSize = context.responsiveTitleSize;
    final subtitleSize = context.responsiveSubtitleSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            height: 1.1,
            letterSpacing: -0.01,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: context.isMobile ? 6 : 8),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: subtitleSize,
              fontWeight: FontWeight.w400,
              height: 1.6,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ],
    );
  }
}

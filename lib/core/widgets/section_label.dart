import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.displaySmall?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            style: context.textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ResultsSection extends StatelessWidget {
  final ProjectData data;
  const ResultsSection({super.key, required this.data});

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
          Text('Results',
              style: TextStyle(
                fontSize: context.responsiveTitleSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -0.01,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
          SizedBox(height: isMobile ? 6 : 8),
          Text(data.resultsSubtitle,
              style: TextStyle(
                fontSize: context.responsiveSubtitleSize,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
          SizedBox(height: sectionGap),
          if (isMobile)
            Column(
              children: data.results.map((r) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: _ResultCard(text: r, isDark: isDark, isMobile: isMobile),
              )).toList(),
            )
          else
            ...List.generate((data.results.length / 2).ceil(), (rowIndex) {
              final start = rowIndex * 2;
              final end = (start + 2).clamp(0, data.results.length);
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: data.results.sublist(start, end).map((r) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: rowIndex > 0 || start > 0 ? 8 : 0,
                        right: rowIndex > 0 || end < data.results.length ? 8 : 0,
                      ),
                      child: _ResultCard(text: r, isDark: isDark, isMobile: isMobile),
                    ),
                  )).toList(),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String text;
  final bool isDark;
  final bool isMobile;
  const _ResultCard({required this.text, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 14 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: isMobile ? 1 : 2),
            width: isMobile ? 18 : 20,
            height: isMobile ? 18 : 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withValues(alpha: 0.1),
            ),
            child: Icon(Icons.check_rounded, size: isMobile ? 11 : 12, color: AppColors.success),
          ),
          SizedBox(width: isMobile ? 10 : 12),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    height: 1.5)),
          ),
        ],
      ),
    );
  }
}

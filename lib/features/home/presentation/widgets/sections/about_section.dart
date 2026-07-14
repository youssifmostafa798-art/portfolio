import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/core/widgets/section_label.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isDark = context.isDark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
            label: 'About Me',
            subtitle: 'A brief introduction to who I am and what I do.',
          ),
          SizedBox(height: isMobile ? 32.h : 48.h),
          if (isMobile)
            _buildMobileLayout(context, isDark)
          else
            _buildDesktopLayout(context, isDark),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _AboutContent(isDark: isDark)),
        SizedBox(width: 64.w),
        Expanded(flex: 4, child: _AboutVisual(isDark: isDark)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AboutVisual(isDark: isDark),
        SizedBox(height: 32.h),
        _AboutContent(isDark: isDark),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  final bool isDark;
  const _AboutContent({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Developer with a background in '
          'Communications and Electronics Engineering.',
          style: context.textTheme.headlineSmall?.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            height: 1.3,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'I build production-grade mobile applications with clean architecture, '
          'real-time capabilities, and premium user experiences. '
          'My work spans the full stack — from designing offline-first local databases '
          'and integrating IoT hardware, to deploying on-device AI models and '
          'managing complex multi-role authentication systems.',
          style: context.textTheme.bodyLarge?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.8,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'I graduated in 2026 with a degree in Communications and Electronics '
          'Engineering, where I developed a strong foundation in embedded systems, '
          'signal processing, and system-level design — skills I now apply daily '
          'to building connected, intelligent mobile experiences.',
          style: context.textTheme.bodyLarge?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.8,
          ),
        ),
        SizedBox(height: 24.h),
        _StatsRow(isDark: isDark),
      ],
    );
  }
}

class _AboutVisual extends StatelessWidget {
  final bool isDark;
  const _AboutVisual({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(32.r),
      child: Column(
        children: [
          Container(
            width: 120.r,
            height: 120.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
            child: Center(
              child: Text(
                'YM',
                style: context.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Youssif Mostafa',
            style: context.textTheme.titleLarge?.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Flutter Mobile Application Developer',
            style: context.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final bool isDark;
  const _StatsRow({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(value: '1+', label: 'Years', isDark: isDark),
        SizedBox(width: 32.w),
        _StatItem(value: '2', label: 'Projects', isDark: isDark),
        SizedBox(width: 32.w),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;

  const _StatItem({
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textTheme.displaySmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}

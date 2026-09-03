import 'package:flutter/material.dart';
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
    final sectionVertical = context.responsiveSectionVertical;
    final sectionGap = context.responsiveSectionGap;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
            label: 'About Me',
            subtitle: 'A brief introduction to who I am and what I do.',
          ),
          SizedBox(height: sectionGap),
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
        SizedBox(width: 64),
        Expanded(flex: 4, child: _AboutVisual(isDark: isDark)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AboutVisual(isDark: isDark),
        SizedBox(height: context.responsiveSectionGap),
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
    final isMobile = context.isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Developer with a background in '
          'Communications and Electronics Engineering.',
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'I build production-grade mobile applications with clean architecture, '
          'real-time capabilities, and premium user experiences. '
          'My work spans the full stack — from designing offline-first local databases '
          'and integrating IoT hardware, to deploying on-device AI models and '
          'managing complex multi-role authentication systems.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.8,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'I graduated in 2026 with a degree in Communications and Electronics '
          'Engineering, where I developed a strong foundation in embedded systems, '
          'signal processing, and system-level design — skills I now apply daily '
          'to building connected, intelligent mobile experiences.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.8,
          ),
        ),
        SizedBox(height: isMobile ? 20 : 24),
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
    final isMobile = context.isMobile;
    final avatarSize = isMobile ? 100.0 : 120.0;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      child: Column(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/5.jpeg',
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Youssif Mostafa',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Flutter Mobile Application Developer',
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
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
    final isMobile = context.isMobile;

    return Row(
      children: [
        _StatItem(
          value: '1+',
          label: 'Years',
          isDark: isDark,
          isMobile: isMobile,
        ),
        SizedBox(width: isMobile ? 24 : 32),
        _StatItem(
          value: '3',
          label: 'Projects',
          isDark: isDark,
          isMobile: isMobile,
        ),
        SizedBox(width: isMobile ? 24 : 32),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;
  final bool isMobile;

  const _StatItem({
    required this.value,
    required this.label,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isMobile ? 28 : 32,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 12 : 13,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}

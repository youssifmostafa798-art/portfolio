import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_spacing.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/utils/url_utils.dart';
import 'package:portfolio/features/project/data/vitaguard_data.dart';

class ProjectHeroSection extends StatelessWidget {
  final VoidCallback? onBackTap;
  const ProjectHeroSection({super.key, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: AppSpacing.huge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onBackTap != null)
            _BackButton(onTap: onBackTap!),
          SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.xxxl),
          _buildHeroContent(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, bool isMobile) {
    final isDark = context.isDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusBadge(isDark: isDark),
        SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
        Text(
          VitaguardData.title,
          style: (isMobile
                  ? context.textTheme.displayMedium
                  : context.textTheme.displayLarge)
              ?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.02,
          ),
        ),
        SizedBox(height: isMobile ? AppSpacing.sm : AppSpacing.md),
        Text(
          VitaguardData.tagline,
          style: context.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
        if (!isMobile)
          Row(
            children: [
              _MetaItem(label: 'Role', value: VitaguardData.role, isDark: isDark),
              const SizedBox(width: AppSpacing.xxl),
              _MetaItem(label: 'Team', value: '${VitaguardData.teamSize} Members', isDark: isDark),
              const SizedBox(width: AppSpacing.xxl),
              _MetaItem(label: 'Timeline', value: VitaguardData.timeline, isDark: isDark),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaItem(label: 'Role', value: VitaguardData.role, isDark: isDark),
              const SizedBox(height: AppSpacing.sm),
              _MetaItem(label: 'Team', value: '${VitaguardData.teamSize} Members', isDark: isDark),
              const SizedBox(height: AppSpacing.sm),
              _MetaItem(label: 'Timeline', value: VitaguardData.timeline, isDark: isDark),
            ],
          ),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: VitaguardData.techStack.take(7).map((t) => _TechChip(label: t, isDark: isDark)).toList(),
        ),
        const SizedBox(height: AppSpacing.xxl),
        _ActionRow(isDark: isDark),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back_rounded, size: 18,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
            const SizedBox(width: 6),
            Text('Back to Portfolio',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isDark;
  const _StatusBadge({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.success.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6, height: 6,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
          const SizedBox(width: 6),
          Text(VitaguardData.status,
              style: AppTypography.textTheme.labelSmall?.copyWith(color: AppColors.success)),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final String label, value;
  final bool isDark;
  const _MetaItem({required this.label, required this.value, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
        const SizedBox(height: 2),
        Text(value, style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final bool isDark;
  const _TechChip({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: Text(label, style: AppTypography.textTheme.labelSmall?.copyWith(
          color: AppColors.primary, fontWeight: FontWeight.w500)),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final bool isDark;
  const _ActionRow({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _PButton(label: 'GitHub', icon: Icons.code_rounded,
            onPressed: () => UrlUtils.openUrl(VitaguardData.githubUrl)),
        _PButton(label: 'Demo Video', icon: Icons.play_arrow_rounded,
            onPressed: () => UrlUtils.openUrl(VitaguardData.demoUrl)),
        _PButton(label: 'View Screenshots', icon: Icons.photo_library_rounded,
            onPressed: () => UrlUtils.openUrl(VitaguardData.screenshotsUrl)),
      ],
    );
  }
}

class _PButton extends StatefulWidget {
  final String label; final IconData icon; final VoidCallback onPressed;
  const _PButton({required this.label, required this.icon, required this.onPressed});

  @override
  State<_PButton> createState() => _PButtonState();
}

class _PButtonState extends State<_PButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered ? Matrix4.translationValues(0, -1, 0) : Matrix4.identity(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary,
                boxShadow: _isHovered
                    ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))]
                    : null,
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(widget.icon, size: 16, color: Colors.white),
                const SizedBox(width: 6),
                Text(widget.label, style: AppTypography.textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

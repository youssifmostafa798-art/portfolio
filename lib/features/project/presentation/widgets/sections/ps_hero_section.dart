import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/utils/url_utils.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class ProjectHeroSection extends StatelessWidget {
  final ProjectData data;
  final VoidCallback? onBackTap;
  const ProjectHeroSection({super.key, required this.data, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: 64.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onBackTap != null)
            _BackButton(onTap: onBackTap!),
          SizedBox(height: isMobile ? 32.h : 48.h),
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
        _StatusBadge(isDark: isDark, status: data.status),
        SizedBox(height: isMobile ? 16.h : 24.h),
        Text(
          data.title,
          style: (isMobile
                  ? context.textTheme.displayMedium
                  : context.textTheme.displayLarge)
              ?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.02,
          ),
        ),
        SizedBox(height: isMobile ? 8.h : 12.h),
        Text(
          data.tagline,
          style: context.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isMobile ? 16.h : 24.h),
        if (!isMobile)
          Row(
            children: [
              _MetaItem(label: 'Role', value: data.role, isDark: isDark),
              SizedBox(width: 32.w),
              _MetaItem(label: 'Team', value: '${data.teamSize} Members', isDark: isDark),
              SizedBox(width: 32.w),
              _MetaItem(label: 'Timeline', value: data.timeline, isDark: isDark),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaItem(label: 'Role', value: data.role, isDark: isDark),
              SizedBox(height: 8.h),
              _MetaItem(label: 'Team', value: '${data.teamSize} Members', isDark: isDark),
              SizedBox(height: 8.h),
              _MetaItem(label: 'Timeline', value: data.timeline, isDark: isDark),
            ],
          ),
        SizedBox(height: 24.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: data.techStackTop.map((t) => _TechChip(label: t, isDark: isDark)).toList(),
        ),
        SizedBox(height: 32.h),
        _ActionRow(data: data, isDark: isDark),
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
            Icon(Icons.arrow_back_rounded, size: 18.r,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
            SizedBox(width: 6.w),
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
  final String status;
  const _StatusBadge({required this.isDark, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: AppColors.success.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6.r, height: 6.r,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
          SizedBox(width: 6.w),
          Text(status,
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
        SizedBox(height: 2.h),
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: Text(label, style: AppTypography.textTheme.labelSmall?.copyWith(
          color: AppColors.primary, fontWeight: FontWeight.w500)),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final ProjectData data;
  final bool isDark;
  const _ActionRow({required this.data, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        _PButton(label: 'GitHub', icon: Icons.code_rounded,
            onPressed: () => UrlUtils.openUrl(data.githubUrl)),
        _PButton(label: 'Demo Video', icon: Icons.play_arrow_rounded,
            onPressed: () => UrlUtils.openUrl(data.demoUrl)),
        _PButton(label: 'View Screenshots', icon: Icons.photo_library_rounded,
            onPressed: () => UrlUtils.openUrl(data.screenshotsUrl)),
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
        transform: _isHovered ? Matrix4.translationValues(0, -1.h, 0) : Matrix4.identity(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.primary,
                boxShadow: _isHovered
                    ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 16.r, offset: Offset(0, 6.h))]
                    : null,
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(widget.icon, size: 16.r, color: Colors.white),
                SizedBox(width: 6.w),
                Text(widget.label, style: AppTypography.textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

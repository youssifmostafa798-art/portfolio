import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/url_utils.dart';
import '../widgets/project_image.dart';
import '../../features/home/models/project.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onCaseStudyTap;

  const ProjectCard({super.key, required this.project, this.onCaseStudyTap});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isDark = context.isDark;
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, -2.h, 0)
            : Matrix4.identity(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            border: Border.all(
              color: isDark
                  ? AppColors.darkDivider.withValues(alpha: 0.5)
                  : AppColors.lightDivider.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.06),
                blurRadius: _isHovered ? 40.r : 20.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: isMobile
              ? _buildMobileLayout(context, project, isDark)
              : _buildDesktopLayout(context, project, isDark),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    Project project,
    bool isDark,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 390.w,
            child: ProjectImage(
              imageUrl: project.imageUrl,
              title: project.title,
              height: double.infinity,
              borderRadius: 0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: _buildContent(context, project, isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    Project project,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectImage(
          imageUrl: project.imageUrl,
          title: project.title,
          height: 240.h,
          borderRadius: 0,
        ),
        Padding(
          padding: EdgeInsets.all(24.w),
          child: _buildContent(context, project, isDark),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, Project project, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          project.title,
          style: context.textTheme.displaySmall?.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          project.subtitle,
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          project.description,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.7,
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: project.technologies.map((tech) {
            return _TechChip(label: tech, isDark: isDark);
          }).toList(),
        ),
        SizedBox(height: 16.h),
        _InfoRow(label: 'Role', value: project.role, isDark: isDark),
        SizedBox(height: 16.h),
        Text(
          'Key Highlights',
          style: context.textTheme.titleSmall?.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        ...project.highlights.map(
          (h) => _HighlightItem(text: h, isDark: isDark),
        ),
        SizedBox(height: 24.h),
        _buildActions(project, isDark),
      ],
    );
  }

  Widget _buildActions(Project project, bool isDark) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        if (project.githubUrl != null)
          _ActionButton(
            label: 'GitHub',
            icon: Icons.code_rounded,
            isDark: isDark,
            variant: _ButtonVariant.outlined,
            onPressed: () => UrlUtils.openUrl(project.githubUrl!),
          ),
        if (project.demoUrl != null)
          _ActionButton(
            label: 'Demo Video',
            icon: Icons.play_arrow_rounded,
            isDark: isDark,
            variant: _ButtonVariant.outlined,
            onPressed: () => UrlUtils.openUrl(project.demoUrl!),
          ),
        _ActionButton(
          label: 'Case Study',
          icon: Icons.article_outlined,
          isDark: isDark,
          variant: _ButtonVariant.primary,
          onPressed: () => widget.onCaseStudyTap?.call(),
        ),
        if (project.googleDriveScreenshotsUrl != null)
          _ActionButton(
            label: 'Gallery',
            icon: Icons.photo_library_outlined,
            isDark: isDark,
            variant: _ButtonVariant.outlined,
            onPressed: () =>
                UrlUtils.openUrl(project.googleDriveScreenshotsUrl!),
          ),
      ],
    );
  }
}

enum _ButtonVariant { primary, outlined }

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isDark;
  final _ButtonVariant variant;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isDark,
    required this.variant,
    required this.onPressed,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == _ButtonVariant.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -1.h, 0)
            : Matrix4.identity(),
        child: Semantics(
          button: true,
          label: 'Open ${widget.label}',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: isPrimary
                      ? AppColors.primary
                      : (widget.isDark
                            ? Colors.white.withValues(
                                alpha: _isHovered ? 0.12 : 0.06,
                              )
                            : Colors.black.withValues(
                                alpha: _isHovered ? 0.08 : 0.04,
                              )),
                  border: isPrimary
                      ? null
                      : Border.all(
                          color: widget.isDark
                              ? AppColors.darkDivider
                              : AppColors.lightDivider,
                        ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      size: 16.r,
                      color: isPrimary
                          ? Colors.white
                          : (widget.isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      widget.label,
                      style: AppTypography.textTheme.labelMedium?.copyWith(
                        color: isPrimary
                            ? Colors.white
                            : (widget.isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
      child: Text(
        label,
        style: AppTypography.textTheme.labelSmall?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: context.textTheme.bodySmall?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodySmall?.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _HighlightItem extends StatelessWidget {
  final String text;
  final bool isDark;

  const _HighlightItem({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 5.r,
              height: 5.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

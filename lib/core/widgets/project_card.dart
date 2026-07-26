import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
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
    final cardRadius = context.responsiveBorderRadius;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, isMobile ? -1 : -2, 0)
            : Matrix4.identity(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cardRadius),
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
                blurRadius: _isHovered ? 40 : 20,
                offset: Offset(0, isMobile ? 4 : 10),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 350,
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: ProjectImage(
              imageUrl: project.imageUrl,
              title: project.title,
              height: double.infinity,
              borderRadius: 0,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: _buildContent(context, project, isDark),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    Project project,
    bool isDark,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.55;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: imageHeight,
          //change
          child: ProjectImage(
            imageUrl: project.imageUrl,
            title: project.title,
            height: double.infinity,
            borderRadius: 0,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: _buildContent(context, project, isDark),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, Project project, bool isDark) {
    final isMobile = context.isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          project.title,
          style: TextStyle(
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.w700,
            height: 1.15,
            letterSpacing: -0.01,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 4),
        Text(
          project.subtitle,
          style: TextStyle(
            fontSize: isMobile ? 13 : 16,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 12),
        Text(
          project.description,
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.7,
          ),
        ),
        SizedBox(height: isMobile ? 14 : 16),
        Wrap(
          spacing: isMobile ? 6 : 8,
          runSpacing: isMobile ? 6 : 8,
          children: project.technologies.map((tech) {
            return _TechChip(label: tech, isDark: isDark, isMobile: isMobile);
          }).toList(),
        ),
        SizedBox(height: isMobile ? 14 : 16),
        _InfoRow(
          label: 'Role',
          value: project.role,
          isDark: isDark,
          isMobile: isMobile,
        ),
        SizedBox(height: isMobile ? 14 : 16),
        Text(
          'Key Highlights',
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: isMobile ? 6 : 8),
        ...project.highlights.map(
          (h) => _HighlightItem(text: h, isDark: isDark, isMobile: isMobile),
        ),
        SizedBox(height: isMobile ? 20 : 24),
        _buildActions(project, isDark, isMobile),
      ],
    );
  }

  Widget _buildActions(Project project, bool isDark, bool isMobile) {
    return Wrap(
      spacing: isMobile ? 8 : 8,
      runSpacing: isMobile ? 8 : 8,
      children: [
        if (project.githubUrl != null)
          _ActionButton(
            label: 'GitHub',
            icon: Icons.code_rounded,
            isDark: isDark,
            isMobile: isMobile,
            variant: _ButtonVariant.outlined,
            onPressed: () => UrlUtils.openUrl(project.githubUrl!),
          ),
        if (project.demoUrl != null)
          _ActionButton(
            label: 'Demo Video',
            icon: Icons.play_arrow_rounded,
            isDark: isDark,
            isMobile: isMobile,
            variant: _ButtonVariant.outlined,
            onPressed: () => UrlUtils.openUrl(project.demoUrl!),
          ),
        _ActionButton(
          label: 'Case Study',
          icon: Icons.article_outlined,
          isDark: isDark,
          isMobile: isMobile,
          variant: _ButtonVariant.primary,
          onPressed: () => widget.onCaseStudyTap?.call(),
        ),
        if (project.googleDriveScreenshotsUrl != null)
          _ActionButton(
            label: 'Gallery',
            icon: Icons.photo_library_outlined,
            isDark: isDark,
            isMobile: isMobile,
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
  final bool isMobile;
  final _ButtonVariant variant;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isDark,
    required this.isMobile,
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
    final btnHeight = context.responsiveButtonMinHeight;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -1, 0)
            : Matrix4.identity(),
        child: Semantics(
          button: true,
          label: 'Open ${widget.label}',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: BoxConstraints(minHeight: btnHeight),
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 14 : 16,
                  vertical: widget.isMobile ? 12 : 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
                      size: widget.isMobile ? 15 : 16,
                      color: isPrimary
                          ? Colors.white
                          : (widget.isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                    ),
                    SizedBox(width: widget.isMobile ? 5 : 6),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 12 : 13,
                        fontWeight: FontWeight.w500,
                        color: isPrimary
                            ? Colors.white
                            : (widget.isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight),
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
  final bool isMobile;

  const _TechChip({
    required this.label,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 12,
        vertical: isMobile ? 5 : 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isMobile ? 11 : 12,
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
  final bool isMobile;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: isMobile ? 12 : 13,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isMobile ? 12 : 13,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _HighlightItem extends StatelessWidget {
  final String text;
  final bool isDark;
  final bool isMobile;

  const _HighlightItem({
    required this.text,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 5 : 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: isMobile ? 8 : 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isMobile ? 12 : 14,
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

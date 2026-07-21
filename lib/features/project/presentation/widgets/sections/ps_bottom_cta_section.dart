import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/utils/url_utils.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/features/project/data/project_data.dart';

class BottomCTASection extends StatelessWidget {
  final ProjectData data;
  final VoidCallback? onBackTap;
  const BottomCTASection({super.key, required this.data, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: 80.h,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 600.w),
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  data.bottomCtaTitle,
                  style: AppTypography.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  data.bottomCtaSubtitle,
                  style: AppTypography.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  alignment: WrapAlignment.center,
                  children: [
                    _CTAButton(
                      label: 'Back to Portfolio',
                      icon: Icons.arrow_back_rounded,
                      isPrimary: false,
                      onPressed: onBackTap ?? () {},
                    ),
                    _CTAButton(
                      label: 'GitHub',
                      icon: Icons.code_rounded,
                      isPrimary: false,
                      onPressed: () => UrlUtils.openUrl(data.githubUrl),
                    ),
                    _CTAButton(
                      label: 'Contact Me',
                      icon: Icons.mail_outline_rounded,
                      isPrimary: true,
                      onPressed: () => UrlUtils.openEmail(AppConstants.email),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;
  const _CTAButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
          label: widget.label,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: widget.isPrimary
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.15),
                  border: widget.isPrimary
                      ? null
                      : Border.all(color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      size: 16.r,
                      color: widget.isPrimary
                          ? AppColors.primary
                          : Colors.white,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      widget.label,
                      style: AppTypography.textTheme.labelMedium?.copyWith(
                        color: widget.isPrimary
                            ? AppColors.primary
                            : Colors.white,
                        fontWeight: FontWeight.w600,
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

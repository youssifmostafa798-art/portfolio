import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/url_utils.dart';

class CaseStudyCta extends StatelessWidget {
  final String? githubUrl;
  final String? demoUrl;
  final VoidCallback? onBackPressed;

  const CaseStudyCta({
    super.key,
    this.githubUrl,
    this.demoUrl,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isMobile = responsive.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: isMobile ? 48 : 80,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 600),
            padding: EdgeInsets.all(isMobile ? 24 : 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.responsiveBorderRadius),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Interested in this project?',
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 6 : 8),
                Text(
                  'Explore the code, watch the demo, or get in touch.',
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 15,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 18 : 24),
                Wrap(
                  spacing: isMobile ? 6 : 8,
                  runSpacing: isMobile ? 6 : 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _CtaButton(
                      label: 'Back to Portfolio',
                      icon: Icons.arrow_back_rounded,
                      isPrimary: false,
                      onPressed: onBackPressed ?? () {},
                      isMobile: isMobile,
                    ),
                    if (githubUrl != null)
                      _CtaButton(
                        label: 'GitHub',
                        icon: Icons.code_rounded,
                        isPrimary: false,
                        onPressed: () => UrlUtils.openUrl(githubUrl!),
                        isMobile: isMobile,
                      ),
                    if (demoUrl != null)
                      _CtaButton(
                        label: 'Demo',
                        icon: Icons.play_circle_outline_rounded,
                        isPrimary: false,
                        onPressed: () => UrlUtils.openUrl(demoUrl!),
                        isMobile: isMobile,
                      ),
                    _CtaButton(
                      label: 'Contact Me',
                      icon: Icons.mail_outline_rounded,
                      isPrimary: true,
                      onPressed: () => UrlUtils.openEmail(AppConstants.email),
                      isMobile: isMobile,
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

class _CtaButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;
  final bool isMobile;

  const _CtaButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
    required this.isMobile,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
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
            ? Matrix4.translationValues(0, -1, 0)
            : Matrix4.identity(),
        child: Semantics(
          button: true,
          label: widget.label,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 14 : 20,
                  vertical: widget.isMobile ? 10 : 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
                      size: widget.isMobile ? 15 : 16,
                      color: widget.isPrimary
                          ? AppColors.primary
                          : Colors.white,
                    ),
                    SizedBox(width: widget.isMobile ? 5 : 6),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 12 : 13,
                        fontWeight: FontWeight.w600,
                        color: widget.isPrimary
                            ? AppColors.primary
                            : Colors.white,
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

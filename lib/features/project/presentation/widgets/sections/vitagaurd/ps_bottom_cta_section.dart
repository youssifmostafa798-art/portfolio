import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
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
                  data.bottomCtaTitle,
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 6 : 8),
                Text(
                  data.bottomCtaSubtitle,
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
                    _CTAButton(
                      label: 'Back to Portfolio',
                      icon: Icons.arrow_back_rounded,
                      isPrimary: false,
                      onPressed: onBackTap ?? () {},
                      isMobile: isMobile,
                    ),
                    _CTAButton(
                      label: 'GitHub',
                      icon: Icons.code_rounded,
                      isPrimary: false,
                      onPressed: () => UrlUtils.openUrl(data.githubUrl),
                      isMobile: isMobile,
                    ),
                    _CTAButton(
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

class _CTAButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;
  final bool isMobile;
  const _CTAButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
    required this.isMobile,
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

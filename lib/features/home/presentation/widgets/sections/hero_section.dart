import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/url_utils.dart';
import 'package:portfolio/core/widgets/glass_card.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final screenWidth = context.screenWidth;

    return SizedBox(
      height: context.screenHeight,
      width: double.infinity,
      child: Stack(
        children: [
          _AnimatedHeroBackground(controller: _bgController),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsivePadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    _ProfileAvatar(size: isMobile ? 80.r : 100.r),
                    SizedBox(height: isMobile ? 24.h : 32.h),
                    Text(
                      AppConstants.appName,
                      textAlign: TextAlign.center,
                      style:
                          (isMobile
                                  ? context.textTheme.displayMedium
                                  : context.textTheme.displayLarge)
                              ?.copyWith(
                                color: AppColors.textPrimaryDark,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.02,
                              ),
                    ),
                    SizedBox(height: isMobile ? 8.h : 12.h),
                    Text(
                      AppConstants.title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: AppColors.textSecondaryDark,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: isMobile ? 16.h : 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 0 : screenWidth * 0.12,
                      ),
                      child: Text(
                        'Building production-grade Flutter applications '
                        'with clean architecture, real-time systems, '
                        'and premium user experiences.',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondaryDark,
                          height: 1.7,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 32.h : 48.h),
                    _ActionButtons(isMobile: isMobile),
                    SizedBox(height: 24.h),
                    _SocialLinks(),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedHeroBackground extends AnimatedWidget {
  final AnimationController controller;
  const _AnimatedHeroBackground({required this.controller})
    : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final value = controller.value;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5 + value * 0.3, -1.0),
              end: Alignment(-0.5 - value * 0.3, 1.0),
              colors: const [
                Color(0xFF0A0A0A),
                Color(0xFF111122),
                Color(0xFF0D0D1A),
              ],
            ),
          ),
        ),
        Positioned(
          left: -100.w + value * 250.w,
          top: -50.h + value * 80.h,
          child: Container(
            width: 350.r,
            height: 350.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: -80.w - value * 120.w,
          bottom: -30.h + value * 100.h,
          child: Container(
            width: 400.r,
            height: 400.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.secondary.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final double size;
  const _ProfileAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 30.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/5.jpeg',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final bool isMobile;
  const _ActionButtons({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      alignment: WrapAlignment.center,
      children: [
        _PrimaryButton(
          label: 'Download CV',
          icon: Icons.download_rounded,
          onPressed: () {},
        ),
        _SecondaryButton(
          label: 'Contact Me',
          icon: Icons.mail_outline_rounded,
          onPressed: () => UrlUtils.openEmail(AppConstants.email),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        label: widget.label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2.h, 0)
              : Matrix4.identity(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 20.r,
                            offset: Offset(0, 8.h),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(widget.icon, size: 18.r, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      widget.label,
                      style: AppTypography.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
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

class _SecondaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        label: widget.label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2.h, 0)
              : Matrix4.identity(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1.w,
                  ),
                  color: Colors.white.withValues(
                    alpha: _isHovered ? 0.12 : 0.06,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      size: 18.r,
                      color: AppColors.textPrimaryDark,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      widget.label,
                      style: AppTypography.textTheme.labelLarge?.copyWith(
                        color: AppColors.textPrimaryDark,
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

class _SocialLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon: Icons.code_rounded,
          label: 'GitHub',
          url: AppConstants.github,
        ),
        SizedBox(width: 16.w),
        _SocialIcon(
          icon: Icons.work_rounded,
          label: 'LinkedIn',
          url: AppConstants.linkedin,
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        label: 'Open ${widget.label}',
        child: GestureDetector(
          onTap: () => UrlUtils.openUrl(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: _isHovered
                ? Matrix4.translationValues(0, -2.h, 0)
                : Matrix4.identity(),
            child: GlassCard(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              borderRadius: 100,
              blurIntensity: 20,
              showBorder: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 18.r,
                    color: _isHovered
                        ? AppColors.primary
                        : AppColors.textSecondaryDark,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    widget.label,
                    style: AppTypography.textTheme.labelMedium?.copyWith(
                      color: _isHovered
                          ? AppColors.textPrimaryDark
                          : AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

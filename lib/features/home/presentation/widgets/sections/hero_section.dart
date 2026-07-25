import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
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
                    _ProfileAvatar(size: isMobile ? 72 : 100),
                    SizedBox(height: isMobile ? 20 : 32),
                    Text(
                      AppConstants.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.w700,
                        height: 1.08,
                        letterSpacing: -0.02,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 12),
                    Text(
                      AppConstants.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondaryDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: isMobile ? 14 : 24),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 0 : screenWidth * 0.12,
                      ),
                      child: Text(
                        'Building production-grade Flutter applications '
                        'with clean architecture, real-time systems, '
                        'and premium user experiences.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 18,
                          color: AppColors.textSecondaryDark,
                          height: 1.7,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 28 : 48),
                    _ActionButtons(isMobile: isMobile),
                    SizedBox(height: isMobile ? 18 : 24),
                    _SocialLinks(isMobile: isMobile),
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
    final isMobile = context.isMobile;

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
          left: -100 + value * 250,
          top: -50 + value * 80,
          child: Container(
            width: isMobile ? 200 : 350,
            height: isMobile ? 200 : 350,
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
          right: -80 - value * 120,
          bottom: -30 + value * 100,
          child: Container(
            width: isMobile ? 240 : 400,
            height: isMobile ? 240 : 400,
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
            blurRadius: 30,
            offset: const Offset(0, 8),
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
      spacing: isMobile ? 10 : 12,
      runSpacing: isMobile ? 10 : 12,
      alignment: WrapAlignment.center,
      children: [
        _PrimaryButton(
          label: 'Download CV',
          icon: Icons.download_rounded,
          onPressed: () => UrlUtils.openUrl(AppConstants.cvUrl),
          isMobile: isMobile,
        ),
        _SecondaryButton(
          label: 'Contact Me',
          icon: Icons.mail_outline_rounded,
          onPressed: () => UrlUtils.openEmail(AppConstants.email),
          isMobile: isMobile,
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isMobile;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.isMobile,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final btnHeight = context.responsiveButtonMinHeight;

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
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                constraints: BoxConstraints(minHeight: btnHeight),
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 20 : 24,
                  vertical: widget.isMobile ? 14 : 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      size: widget.isMobile ? 17 : 18,
                      color: Colors.white,
                    ),
                    SizedBox(width: widget.isMobile ? 6 : 8),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 13 : 14,
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
  final bool isMobile;

  const _SecondaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.isMobile,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final btnHeight = context.responsiveButtonMinHeight;

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
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                constraints: BoxConstraints(minHeight: btnHeight),
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 20 : 24,
                  vertical: widget.isMobile ? 14 : 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
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
                      size: widget.isMobile ? 17 : 18,
                      color: AppColors.textPrimaryDark,
                    ),
                    SizedBox(width: widget.isMobile ? 6 : 8),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 13 : 14,
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
  final bool isMobile;
  const _SocialLinks({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon: Icons.code_rounded,
          label: 'GitHub',
          url: AppConstants.github,
          isMobile: isMobile,
        ),
        SizedBox(width: isMobile ? 12 : 16),
        _SocialIcon(
          icon: Icons.work_rounded,
          label: 'LinkedIn',
          url: AppConstants.linkedin,
          isMobile: isMobile,
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isMobile;

  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.url,
    required this.isMobile,
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
                ? Matrix4.translationValues(0, -2, 0)
                : Matrix4.identity(),
            child: GlassCard(
              padding: EdgeInsets.symmetric(
                horizontal: widget.isMobile ? 14 : 16,
                vertical: widget.isMobile ? 12 : 10,
              ),
              borderRadius: 100,
              blurIntensity: 20,
              showBorder: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: widget.isMobile ? 17 : 18,
                    color: _isHovered
                        ? AppColors.primary
                        : AppColors.textSecondaryDark,
                  ),
                  SizedBox(width: widget.isMobile ? 5 : 6),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.isMobile ? 13 : 14,
                      fontWeight: FontWeight.w500,
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

import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';

class ProjectImage extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final double height;
  final double? width;
  final double borderRadius;
  //edit
  const ProjectImage({
    super.key,
    this.imageUrl,
    required this.title,
    this.height = 700,
    this.width,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imageUrl!,
          height: height,
          width: width,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return _AppPlaceholder(
              title: title,
              height: height,
              width: width,
              borderRadius: borderRadius,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return _AppPlaceholder(
              title: title,
              height: height,
              width: width,
              borderRadius: borderRadius,
            );
          },
        ),
      );
    }

    return _AppPlaceholder(
      title: title,
      height: height,
      width: width,
      borderRadius: borderRadius,
    );
  }
}

class _AppPlaceholder extends StatelessWidget {
  final String title;
  final double height;
  final double? width;
  final double borderRadius;

  const _AppPlaceholder({
    required this.title,
    required this.height,
    this.width,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final logoSize = context.isMobile ? 52.0 : 64.0;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF0D1B2A)],
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/logo.jpeg',
                    width: logoSize,
                    height: logoSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: context.isMobile ? 18 : 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Health Monitoring',
                style: TextStyle(
                  fontSize: context.isMobile ? 13 : 14,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: Container(
              width: context.isMobile ? 32 : 40,
              height: context.isMobile ? 32 : 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.4),
                  width: 3,
                ),
              ),
              child: Center(
                child: Container(
                  width: context.isMobile ? 10 : 12,
                  height: context.isMobile ? 10 : 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

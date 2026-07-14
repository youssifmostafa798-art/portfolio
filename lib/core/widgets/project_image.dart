import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class ProjectImage extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final double height;
  final double? width;
  final double borderRadius;

  const ProjectImage({
    super.key,
    this.imageUrl,
    required this.title,
    this.height = 320,
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
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D1B2A),
            Color(0xFF1B2838),
            Color(0xFF0D1B2A),
          ],
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
          // Glowing orb decoration
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
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: AppTypography.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Health Monitoring',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          // Decorative pulse ring
          Positioned(
            bottom: 30,
            right: 30,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.4),
                  width: 3,
                ),
              ),
              child: Center(
                child: Container(
                  width: 12,
                  height: 12,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        borderRadius: BorderRadius.circular(borderRadius.r),
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
        borderRadius: BorderRadius.circular(borderRadius.r),
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
          Positioned(
            top: -40.h,
            right: -40.w,
            child: Container(
              width: 200.r,
              height: 200.r,
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
            bottom: -60.h,
            left: -60.w,
            child: Container(
              width: 250.r,
              height: 250.r,
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
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 32.r,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: AppTypography.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Health Monitoring',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30.h,
            right: 30.w,
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.4),
                  width: 3.w,
                ),
              ),
              child: Center(
                child: Container(
                  width: 12.r,
                  height: 12.r,
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

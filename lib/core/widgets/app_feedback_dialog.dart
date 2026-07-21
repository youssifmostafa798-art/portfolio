import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';

class AppFeedbackDialog extends StatelessWidget {
  final bool isSuccess;
  final String title;
  final String message;

  const AppFeedbackDialog({
    super.key,
    required this.isSuccess,
    required this.title,
    required this.message,
  });

  static Future<void> show({
    required BuildContext context,
    required bool isSuccess,
    required String title,
    required String message,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Feedback',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.85, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return AppFeedbackDialog._internal(
          isSuccess: isSuccess,
          title: title,
          message: message,
        );
      },
    );
  }

  const AppFeedbackDialog._internal({
    required this.isSuccess,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withValues(alpha: 0.92)
                    : AppColors.lightSurface.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 0.5.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                    blurRadius: 40.r,
                    offset: Offset(0, 16.h),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 36.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIcon(isDark),
                  SizedBox(height: 24.h),
                  Text(
                    title,
                    style: AppTypography.textTheme.headlineSmall?.copyWith(
                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    message,
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  _buildOkButton(context, isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(bool isDark) {
    final color = isSuccess ? AppColors.success : AppColors.error;
    final icon = isSuccess ? Icons.check_circle_rounded : Icons.error_rounded;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 48.sp,
        color: color,
      ),
    );
  }

  Widget _buildOkButton(BuildContext context, bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'OK',
          style: AppTypography.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

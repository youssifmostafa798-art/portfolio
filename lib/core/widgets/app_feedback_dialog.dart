import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';

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
    final isMobile = context.isMobile;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? 320 : 420),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.responsiveBorderRadius + 2),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withValues(alpha: 0.92)
                    : AppColors.lightSurface.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(context.responsiveBorderRadius + 2),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 28 : 36,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIcon(isDark, isMobile),
                  SizedBox(height: isMobile ? 18 : 24),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 10 : 12),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 15,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 24 : 32),
                  _buildOkButton(context, isDark, isMobile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(bool isDark, bool isMobile) {
    final color = isSuccess ? AppColors.success : AppColors.error;
    final icon = isSuccess ? Icons.check_circle_rounded : Icons.error_rounded;
    final iconContainerSize = isMobile ? 56.0 : 64.0;
    final iconSize = isMobile ? 36.0 : 48.0;

    return Container(
      padding: const EdgeInsets.all(14),
      width: iconContainerSize,
      height: iconContainerSize,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: color,
      ),
    );
  }

  Widget _buildOkButton(BuildContext context, bool isDark, bool isMobile) {
    return SizedBox(
      width: double.infinity,
      height: context.responsiveButtonMinHeight,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'OK',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

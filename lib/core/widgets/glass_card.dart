import 'dart:ui';
import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double blurIntensity;
  final bool showBorder;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
    this.margin = EdgeInsets.zero,
    this.blurIntensity = 30,
    this.showBorder = true,
    this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final bgColor = isDark
        ? AppColors.glassDark(AppColors.darkSurface)
        : AppColors.glassLight(AppColors.lightSurface);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.3);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurIntensity,
                sigmaY: blurIntensity,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: showBorder
                      ? Border.all(color: borderColor, width: 0.5)
                      : null,
                ),
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  AppTypography._();

  static TextTheme get textTheme {
    final base = GoogleFonts.interTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        height: 1.05,
        letterSpacing: -0.02,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.08,
        letterSpacing: -0.015,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.01,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: -0.005,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.35,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.6,
        letterSpacing: 0.01,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.02,
      ),
    );
  }
}

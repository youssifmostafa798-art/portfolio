import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF007AFF);
  static const Color primaryLight = Color(0xFF409CFF);
  static const Color primaryDark = Color(0xFF0040DD);
  static const Color secondary = Color(0xFF5E5CE6);
  static const Color accent = Color(0xFF32D74B);

  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);

  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2E);
  static const Color darkDivider = Color(0xFF38383A);

  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFE8E8ED);
  static const Color lightDivider = Color(0xFFD1D1D6);

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF98989D);
  static const Color textTertiaryDark = Color(0xFF636366);

  static const Color textPrimaryLight = Color(0xFF1C1C1E);
  static const Color textSecondaryLight = Color(0xFF6E6E73);
  static const Color textTertiaryLight = Color(0xFFAEAEB2);

  static Color glassDark(Color surface) {
    return surface.withValues(alpha: 0.12);
  }

  static Color glassLight(Color surface) {
    return surface.withValues(alpha: 0.72);
  }
}

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: AppColors.textPrimaryDark,
      onSecondary: AppColors.textPrimaryDark,
      onSurface: AppColors.textPrimaryDark,
      onError: AppColors.textPrimaryDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      dividerColor: AppColors.darkDivider,
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceVariant,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground.withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
      error: AppColors.error,
      onPrimary: AppColors.textPrimaryLight,
      onSecondary: AppColors.textPrimaryLight,
      onSurface: AppColors.textPrimaryLight,
      onError: AppColors.textPrimaryLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      dividerColor: AppColors.lightDivider,
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground.withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimaryLight,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

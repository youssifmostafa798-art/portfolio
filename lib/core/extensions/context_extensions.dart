import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get shortestSide => screenSize.shortestSide;

  bool get isDark => theme.brightness == Brightness.dark;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  double get responsivePadding {
    if (isMobile) return 20;
    if (isTablet) return 40;
    return 80;
  }

  double get responsiveMaxContentWidth {
    if (isMobile) return screenWidth;
    return 1200;
  }

  double get responsiveSectionVertical {
    if (isMobile) return 64;
    if (isTablet) return 80;
    return 120;
  }

  double get responsiveSectionGap {
    if (isMobile) return 16;
    if (isTablet) return 24;
    return 48;
  }

  double get responsiveCardPadding {
    if (isMobile) return 16;
    if (isTablet) return 20;
    return 32;
  }

  double get responsiveIconSize {
    if (isMobile) return 32;
    if (isTablet) return 40;
    return 48;
  }

  double get responsiveIconContainerSize {
    if (isMobile) return 48;
    if (isTablet) return 56;
    return 64;
  }

  double get responsiveTitleSize {
    if (isMobile) return 24;
    if (isTablet) return 30;
    return 36;
  }

  double get responsiveSubtitleSize {
    if (isMobile) return 14;
    if (isTablet) return 16;
    return 18;
  }

  double get responsiveBodySize {
    if (isMobile) return 14;
    if (isTablet) return 15;
    return 16;
  }

  double get responsiveButtonMinHeight {
    if (isMobile) return 48;
    return 44;
  }

  double get responsiveBorderRadius {
    if (isMobile) return 14;
    if (isTablet) return 18;
    return 20;
  }
}

extension ResponsiveValues on BuildContext {
  ResponsiveData get responsive => ResponsiveData(
    isMobile: isMobile,
    isTablet: isTablet,
    isDesktop: isDesktop,
    isDark: isDark,
    responsivePadding: responsivePadding,
    screenWidth: screenWidth,
  );
}

class ResponsiveData {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final bool isDark;
  final double responsivePadding;
  final double screenWidth;

  const ResponsiveData({
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
    required this.isDark,
    required this.responsivePadding,
    required this.screenWidth,
  });

  int get crossAxisCount => isMobile ? 1 : (isTablet ? 2 : 3);
}

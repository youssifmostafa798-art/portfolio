import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppSpacing {
  AppSpacing._();

  static double get xxs => 2.w;
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;
  static double get xxxl => 48.w;
  static double get huge => 64.w;
  static double get massive => 80.w;
  static double get colossal => 120.w;

  static double get sectionVertical => 120.h;
  static double get sectionHorizontal => 24.w;

  static double get pageMaxWidth => 1200.w;
  static double get pagePaddingDesktop => 80.w;
  static double get pagePaddingTablet => 40.w;
  static double get pagePaddingMobile => 20.w;
}

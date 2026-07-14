import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/context_extensions.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? customPadding;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.customPadding,
  });

  @override
  Widget build(BuildContext context) {
    final padding = customPadding ?? EdgeInsets.symmetric(
      horizontal: context.responsivePadding,
      vertical: context.isMobile ? 40.h : 80.h,
    );

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.responsiveMaxContentWidth,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

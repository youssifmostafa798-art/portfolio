import 'package:flutter/material.dart';

abstract final class AppAnimations {
  AppAnimations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration verySlow = Duration(milliseconds: 900);

  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve spring = Curves.fastOutSlowIn;

  static const List<Offset> slideDirections = [
    Offset(0, 0.1),
    Offset(0, -0.1),
    Offset(0.1, 0),
    Offset(-0.1, 0),
  ];
}

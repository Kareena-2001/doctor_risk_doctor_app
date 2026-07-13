import 'package:flutter/material.dart';

class Responsive {
  static late Size _size;
  static late double _scale;

  static void init(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _scale = (_size.width / 390).clamp(0.85, 1.35);
  }

  static double w(double value) => value * _scale;

  static double h(double value) => value * _scale;

  static double sp(double value) => value * _scale;

  static double get screenWidth => _size.width;

  static double get screenHeight => _size.height;

  static bool get isSmall => screenWidth < 360;

  static bool get isTablet => screenWidth >= 600;
}
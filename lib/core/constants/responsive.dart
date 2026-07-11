import 'package:flutter/material.dart';

class Responsive {
  static late double _width;
  static late double _height;
  static late double _textScale;

  static void init(BuildContext context) {
    final mq = MediaQuery.of(context);
    _width = mq.size.width;
    _height = mq.size.height;
    _textScale = (_width / 390).clamp(0.75, 1.2);
  }

  static double w(double px) => (_width / 390) * px;

  static double h(double px) => (_height / 844) * px;

  static double sp(double px) => _textScale * px;

  static bool get isSmall => _width < 360;

  static bool get isMedium => _width >= 360 && _width < 410;

  static bool get isLarge => _width >= 410;
}

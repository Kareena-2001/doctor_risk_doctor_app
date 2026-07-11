import 'package:flutter/material.dart';

class AppDimens {
  static const double horizontalPadding = 20;
  static const double buttonHeight = 56;
  static const double borderRadius = 30;
}

extension ScreenSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}

SizedBox height20(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height / 120);
}

SizedBox height8(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height / 8);
}

SizedBox height80(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height / 80);
}

SizedBox height70(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height / 70);
}

SizedBox height(double height) {
  return SizedBox(height: height);
}

SizedBox height5() {
  return const SizedBox(height: 5.5);
}

SizedBox height65(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height * 0.08);
}

SizedBox width(double width) {
  return SizedBox(width: width);
}

SizedBox width40(double width) {
  return SizedBox(width: width / 40);
}

SizedBox width15(double width) {
  return SizedBox(width: width / 15);
}

SizedBox width5(double width) {
  return SizedBox(width: width / 5);
}

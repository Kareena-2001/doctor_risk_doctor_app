import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  const HeaderClipper();

  @override
  Path getClip(Size size) {
    final path = Path();

    final curveStart = size.height * 0.76;

    final curveDepth = size.width * 0.10;

    path.lineTo(0, curveStart);

    path.quadraticBezierTo(
      size.width * .5,
      size.height + curveDepth,
      size.width,
      curveStart,
    );

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
import 'package:flutter/widgets.dart';

class SizeUtils {
  static late BuildContext _context;

  static void init(BuildContext context) {
    _context = context;
  }

  static Size get size => MediaQuery.of(_context).size;

  static double get height => size.height;

  static double get width => size.width;
}

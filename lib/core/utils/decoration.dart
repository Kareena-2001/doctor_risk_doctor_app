import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

BoxDecoration cardDecoration(BuildContext context, {double radius = 16}) {
  return BoxDecoration(
    color: context.secondaryBackgroundColor,
    borderRadius: BorderRadius.circular(Responsive.w(radius)),
    border: Border.all(color: context.borderColor),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

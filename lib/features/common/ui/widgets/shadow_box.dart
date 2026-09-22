import 'package:flutter/material.dart';

import '/extensions/build_context_extension.dart';

class ShadowBox extends StatelessWidget {
  final Widget child;
  final double radius;

  const ShadowBox({
    super.key,
    required this.child,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withValues(alpha: 0.24)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

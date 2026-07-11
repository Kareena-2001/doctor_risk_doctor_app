import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

import '../../../core/constants/languages.dart';
import '../../../core/constants/values/app_constants.dart';

class CustomInfoMsg extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const CustomInfoMsg({
    super.key,
    required this.text,
    this.icon = Icons.info,
    this.color = Colors.blue,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: customTextStyle(fontSize: 12, color: Colors.blue.shade900),
            ),
          ),
        ],
      ),
    );
  }
}

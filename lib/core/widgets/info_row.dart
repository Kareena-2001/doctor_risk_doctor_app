import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';

/// A single "icon · label · value" row, with an optional chip-style
/// background for the value (used for status badges).
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
     this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueBackgroundColor,
  });

  final IconData? icon;
  final String label;
  final String value;
  final Color? valueColor;
  final Color? valueBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: Responsive.sp(14), color: const Color(0xFF9CA3AF)),
        width(Responsive.w(7)),
        SizedBox(
          width: Responsive.w(48),
          child: Text(
            label,
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: valueBackgroundColor != null
                ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(8),
                vertical: Responsive.h(4),
              ),
              decoration: BoxDecoration(
                color: valueBackgroundColor,
                borderRadius: BorderRadius.circular(Responsive.w(12)),
              ),
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: customTextStyle(
                  fontSize: Responsive.sp(10.5),
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? const Color(0xFF374151),
                ),
              ),
            )
                : Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                fontWeight: FontWeight.w500,
                color: valueColor ?? const Color(0xFF374151),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
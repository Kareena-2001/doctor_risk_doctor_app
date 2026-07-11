import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String? subtitle;
  final VoidCallback onTap;
  final String? buttonText;

  const HeadingWidget({
    super.key,
    required this.headingTitle,
    required this.onTap,
    this.buttonText,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headingTitle,
                style: customTextStyle(
                  fontSize: Responsive.sp(15),
                  fontWeight: FontWeight.w600,
                ),
              ),

              if (subtitle != null) ...[
                SizedBox(height: Responsive.h(4)),
                Text(
                  subtitle!,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ],
          ),

          if (buttonText != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                buttonText!,
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  color: AppColors.newPri,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
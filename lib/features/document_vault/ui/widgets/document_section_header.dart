import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DocumentSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const DocumentSectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(
            fontSize: Responsive.sp(16),
            fontWeight: FontWeight.w700,
            color: context.primaryTextColor,
          ),
        ),
        height(Responsive.h(4)),
        Text(
          subtitle,
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            color: AppColors.homeTextMuted,
          ),
        ),
      ],
    );
  }
}

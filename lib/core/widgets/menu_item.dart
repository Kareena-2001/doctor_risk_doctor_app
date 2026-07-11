import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../constants/dimensions.dart';
import '../constants/responsive.dart';
import '../constants/values/app_text_style.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(
            vertical: Responsive.sp(8),
            horizontal: Responsive.sp(15),
          ),
          padding: EdgeInsets.symmetric(
            vertical: Responsive.sp(5),
            horizontal: Responsive.sp(15),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? AppColors.white : Colors.transparent,
              width: 1.5,
            ),
            color: isSelected
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                width: Responsive.w(40),
                height: Responsive.h(40),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.white, size: 22),
              ),
              width(Responsive.w(25)),
              Text(
                title,
                style: customTextStyle(
                  fontSize: Responsive.sp(16),
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

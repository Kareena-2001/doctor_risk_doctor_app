import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RaiseTicketFab extends StatelessWidget {
  final VoidCallback onTap;

  const RaiseTicketFab({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.newPri, AppColors.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(16),
              vertical: Responsive.h(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add, color: Colors.white),
                width(Responsive.w(8)),
                Text(
                  'Raise Ticket',
                  style: customTextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
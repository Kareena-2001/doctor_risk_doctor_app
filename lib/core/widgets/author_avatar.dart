
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthorAvatar extends StatelessWidget {
  final String name;

  const AuthorAvatar({super.key, required this.name});

  String get _initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: Responsive.w(16),
      backgroundColor: AppColors.newPri.withValues(alpha: 0.12),
      child: Text(
        _initials,
        style: customTextStyle(
          fontSize: Responsive.sp(11),
          fontWeight: FontWeight.bold,
          color: AppColors.newPri,
        ),
      ),
    );
  }
}

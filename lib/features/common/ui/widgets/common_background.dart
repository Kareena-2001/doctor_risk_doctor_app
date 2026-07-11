import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../theme/app_colors.dart';

class CommonBackground extends StatelessWidget {
  const CommonBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
      ),
    );
  }
}

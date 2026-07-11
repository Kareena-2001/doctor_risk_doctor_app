import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/theme/app_colors.dart';

import '../../../../core/constants/assets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      constraints: const BoxConstraints.expand(),
      color: isDark
          ? AppColors.mono100.withValues(alpha: 0.65)
          : AppColors.mono0.withValues(alpha: 0.45),
      child: Center(
        child: Lottie.asset(Assets.loading, width: 120, height: 120),
      ),
    );
  }
}

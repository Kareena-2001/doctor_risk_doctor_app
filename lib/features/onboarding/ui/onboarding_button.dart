import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_colors.dart';
import '../provider/onboarding_provider.dart';

class OnBoardingButton extends ConsumerWidget {
  const OnBoardingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return PrimaryButton(
      width: MediaQuery.of(context).size.width * .9,
      gradientColors: [AppColors.buttonColor1, AppColors.buttonColor2],
      text: controller.currentPage == 2 ? "Get Started" : "Next",
      onPressed: () => controller.next(context),
    );
  }
}

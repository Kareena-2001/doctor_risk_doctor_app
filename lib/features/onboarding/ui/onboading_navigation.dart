import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/onboarding_provider.dart';

class OnBoardingNavigation extends ConsumerWidget {
  const OnBoardingNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SmoothPageIndicator(
      controller: controller.pageController,
      count: 3,
      onDotClicked: controller.goToPage,
      effect: const ExpandingDotsEffect(
        activeDotColor: Color(0xff0A5EB0),
        dotColor: Colors.grey,
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 3,
      ),
    );
  }
}

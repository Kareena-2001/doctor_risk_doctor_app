import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/responsive.dart';
import '../model/onboarding_model.dart';
import '../provider/onboarding_provider.dart';
import 'onboading_navigation.dart';
import 'onboarding_button.dart';
import 'widgets/onboarding_widget.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  final List<OnboardingModel> _data = const [
    OnboardingModel(
      image: "assets/images/ob_1.png",
      title: "PROTECT YOUR PRACTICE",
      subTitle: "Trusted partner for professional indemnity and legal defense.",
    ),
    OnboardingModel(
      image: "assets/images/ob_1.png",
      title: "24/7 MEDICO-LEGAL SUPPORT",
      subTitle: "Emergency aid, documentation, and expert guidance.",
    ),
    OnboardingModel(
      image: "assets/images/ob_1.png",
      title: "LEARN & CONNECT",
      subTitle: "Risk management resources, workshops, and peer community.",
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Responsive.init(context);
    final controller = ref.watch(onboardingControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return OnboardingWidget(
                    imagePath: _data[index].image,
                    title: _data[index].title,
                    subTitle: _data[index].subTitle,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(24)),
              child: Column(
                children: [
                  const OnBoardingNavigation(),
                  SizedBox(height: Responsive.h(24)),
                  const OnBoardingButton(),
                  SizedBox(height: Responsive.h(24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

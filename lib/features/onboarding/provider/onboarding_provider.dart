import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../repository/onboarding_repository.dart';

final onboardingControllerProvider =
    ChangeNotifierProvider<OnboardingController>((ref) {
      return OnboardingController(ref);
    });

class OnboardingController extends ChangeNotifier {
  OnboardingController(this.ref);

  final Ref ref;

  final PageController pageController = PageController();

  int currentPage = 0;

  void onPageChanged(int page) {
    currentPage = page;
    notifyListeners();
  }

  Future<void> next(BuildContext context) async {
    if (currentPage < 2) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await ref.read(onboardingRepositoryProvider).complete();

      if (context.mounted) {
        context.go(Routes.login);
      }
    }
  }

  Future<void> goToPage(int index) async {
    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

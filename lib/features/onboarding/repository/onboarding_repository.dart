import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final onboardingRepositoryProvider = Provider((ref) => OnboardingRepository());

class OnboardingRepository {
  static const String _key = "onboarding_completed";

  Future<bool> isCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("onboarding_completed");
    return prefs.getBool(_key) ?? false;
  }

  Future<void> complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}

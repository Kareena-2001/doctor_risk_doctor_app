import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_constants.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_theme.dart';
import '../../app_version/app_update_checker.dart';
import '../../authentication/repository/authentication_repository.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 291,
                    height: 187,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Designed & Developed By\n Mobisoftseo Technologies",
                textAlign: TextAlign.center,
                style: AppTheme.label12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkLoginStatus() async {
    final needsForceUpdate = await AppUpdateChecker.checkForUpdate(
      context,
      ref,
    );

    if (needsForceUpdate) return;

    final repo = ref.read(authenticationRepositoryProvider);
    final isLoggedIn = await repo.isLogin();

    debugPrint(
      '${AppConstants.tag} [SplashScreen._checkLoginStatus] isLoggedIn = $isLoggedIn',
    );

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (isLoggedIn) {
      context.pushReplacement(Routes.main);
    } else {
      context.pushReplacement(Routes.login);
    }
  }
}

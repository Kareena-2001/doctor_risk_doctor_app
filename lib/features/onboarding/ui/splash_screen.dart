import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_theme.dart';
import '../../app_version/app_update_checker.dart';
import '../../authentication/repository/authentication_repository.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final needsForceUpdate = await AppUpdateChecker.checkForUpdate(
      context,
      ref,
    );

    if (needsForceUpdate) return;

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final repo = ref.read(authenticationRepositoryProvider);
    final isLoggedIn = await repo.isLogin();

    if (!mounted) return;

    if (isLoggedIn) {
      context.go(Routes.main);
    } else {
      context.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    height: 180,
                  ),
                ),
              ],
            ),
            Padding(
              // padding: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 40,
              ),
              // bottom: MediaQuery.of(context).padding.bottom + 40,
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
}

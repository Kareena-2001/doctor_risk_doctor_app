import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/routing/router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'extensions/build_context_extension.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: const MainApp(),
      // child: DevicePreview(builder: (context) => const MainApp()),
    ),
  );
  // runApp(
  //   const MainApp(),
  //   // DevicePreview(builder: (context) => const DoctorRiskApp()),
  // );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return MaterialApp.router(
      theme: context.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/routing/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'extensions/build_context_extension.dart';
import 'features/common/ui/providers/app_theme_mode_provider.dart';
import 'features/common/ui/widgets/offline_container.dart';
import 'features/fcm/notification_service.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   debugPrint(' Background message: ${message.messageId}');
//   debugPrint(" Background notification: ${message.notification?.title}");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // try {
  //   final app = Firebase.app();
  //   debugPrint('Already initialized: ${app.name}');
  // } catch (_) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  // await FirebaseAnalytics.instance.logAppOpen();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vi')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MainApp(),
        // child: DevicePreview(builder: (context) => const MainApp()),
      ),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  bool _notificationsInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      theme: context.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Only initialize once when builder is first called
        if (!_notificationsInitialized) {
          _notificationsInitialized = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _initializeNotifications(context);
          });
        }

        return OfflineContainer(child: child);
      },
    );
  }

  Future<void> _initializeNotifications(BuildContext context) async {
    if (!mounted) return;

    final notificationService = ref.read(notificationServiceProvider);

    try {
      debugPrint('🔔 Starting notification initialization...');
      await notificationService.requestNotificationPermission();
      await notificationService.initLocalNotification(context);
      notificationService.firebaseInit(context);
      await notificationService.setupInteractMessage(context);
      await notificationService.iosForegroundMessage();

      debugPrint('✅ Notifications initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing notifications: $e');
    }
  }
}

import 'package:Doctors_App/routing/router.dart';
import 'package:Doctors_App/utils/provider_observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/responsive.dart';
import 'features/common/ui/widgets/offline_container.dart';
import 'features/fcm/notification_service.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('🔔 Background message: ${message.messageId}');
  debugPrint('🔔 Background title: ${message.notification?.title}');
  debugPrint('🔔 Background body: ${message.notification?.body}');
  debugPrint('🔔 Background data: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  }

  await FirebaseAnalytics.instance.logAppOpen();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(ProviderScope(observers: [AppObserver()], child: MainApp()));
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
    // final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      // theme: context.lightTheme,
      // darkTheme: context.darkTheme,
      // themeMode: themeMode.value,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        Responsive.init(context);
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
          ),
        );

        if (!_notificationsInitialized) {
          _notificationsInitialized = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _initializeNotifications(context);
          });
        }

        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: OfflineContainer(child: child!),
        );
      },
    );
  }

  Future<void> _initializeNotifications(BuildContext context) async {
    if (!mounted) return;

    final notificationService = ref.read(notificationServiceProvider);

    try {
      debugPrint(' Starting notification initialization...');
      await notificationService.requestNotificationPermission();
      await notificationService.initLocalNotification(context);
      notificationService.firebaseInit(context);
      await notificationService.setupInteractMessage(context);
      await notificationService.iosForegroundMessage();

      debugPrint(' Notifications initialized successfully');
    } catch (e) {
      debugPrint(' Error initializing notifications: $e');
    }
  }
}

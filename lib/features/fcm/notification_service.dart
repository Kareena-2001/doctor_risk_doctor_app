import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// import '../../core/navigation/main_tab_state.dart';
import '../../routing/router.dart';

// import '../notification/ui/viewmodel/notification_count_provider.dart';
import '../notification/ui/viewmodel/notification_view_model.dart';
// import 'notification_navigator.dart';

final unreadNotificationCountProvider = StateProvider<int>((ref) => 0);

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref);
});

class NotificationService {
  final Ref _ref;

  NotificationService(this._ref);

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _listenerAttached = false;

  static const String _channelId = 'doctor_app_notifications';
  static const String _channelName = 'Doctor App Notifications';
  static const String _channelDescription = 'Notifications from Doctor App';

  /// Always use this for navigation triggered from outside the widget tree
  /// (FCM callbacks, local-notification taps). A manually-saved BuildContext
  /// can go stale or simply not have GoRouter as an ancestor -- this key,
  /// once wired to GoRouter's `navigatorKey`, never has that problem.
  // BuildContext? get _navContext => rootNavigatorKey.currentContext;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: false,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        log("✅ User granted notification permissions.");
        break;
      case AuthorizationStatus.provisional:
        log("⚠️ User granted provisional notification permissions.");
        break;
      case AuthorizationStatus.denied:
        log("❌ User denied notification permissions.");
        break;
      default:
        log(
          "ℹ️ Notification permission status: ${settings.authorizationStatus}",
        );
    }
  }

  Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    log("✅ Notification channel created: $_channelId");
  }

  Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      log("📱 Device Token: $token");
      return token;
    } catch (e) {
      log("❌ Error retrieving device token: $e");
      return null;
    }
  }

  Future<void> initLocalNotification([BuildContext? context]) async {
    if (_isInitialized) {
      log("⚠️ Notifications already initialized, skipping...");
      return;
    }

    log("🔔 Initializing local notifications...");

    const androidSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        log("📲 Notification response received in callback");
        _handleNotificationTap(response);
      },
    );

    await createNotificationChannel();

    _isInitialized = true;
    log("✅ Local notifications initialized successfully");
  }

  void firebaseInit(BuildContext context) {
    if (_listenerAttached) {
      log("⚠️ Firebase listener already attached, skipping...");
      return;
    }

    log("🔔 Setting up Firebase messaging listener...");

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log("🔔🔔🔔 ==========================================");
        log("🔔 NOTIFICATION RECEIVED FROM FIREBASE!");
        log("🔔 Message ID: ${message.messageId}");
        log("🔔 Title: ${message.notification?.title}");
        log("🔔 Body: ${message.notification?.body}");
        log("🔔 Data: ${message.data}");
        log("🔔🔔🔔 ==========================================");

        _ref.invalidate(notificationViewModelProvider);

        try {
          final notification = message.notification;
          if (notification != null) {
            log("📬 Processing notification...");

            // final currentCount =
            //     _ref.read(notificationCountProvider).valueOrNull ?? 0;
            // _ref
            //     .read(notificationCountProvider.notifier)
            //     .showAlert(currentCount + 1);
            // log(
            //   "📊 Notification badge count incremented to: ${currentCount + 1}",
            // );

            final legacyCount = _ref.read(unreadNotificationCountProvider);
            _ref.read(unreadNotificationCountProvider.notifier).state =
                legacyCount + 1;

            showNotification(message);
          } else {
            log("⚠️ Notification object is null, only data payload received");
            log("⚠️ Data: ${message.data}");
          }
        } catch (e, stackTrace) {
          log("❌ Error handling Firebase message: $e");
          log("❌ StackTrace: $stackTrace");
        }
      },
      onError: (error) {
        log("❌ Error in onMessage stream: $error");
      },
      onDone: () {
        log("⚠️ onMessage stream closed");
      },
    );

    _listenerAttached = true;
    log("✅ Firebase messaging listener initialized and attached");
  }

  /// Backend uses different id keys depending on the payload source:
  /// - notification_list API always uses `type_id`
  /// - FCM `data` payload has been seen using `task_id` (not `type_id`)
  /// This tries every key we've seen so far, in order.
  String _extractTypeId(Map<String, dynamic> data) {
    return (data['type_id'] ??
            data['task_id'] ??
            data['leave_id'] ??
            data['attendance_id'] ??
            '')
        .toString();
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      log("🔔 Attempting to show notification...");

      const androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        ticker: 'New notification',
        icon: '@mipmap/ic_launcher',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final title = message.notification?.title ?? "New Notification";
      final body = message.notification?.body ?? "You have a new message";

      log(
        "🔔 Showing notification - ID: $notificationId, Title: $title, Body: $body",
      );

      // Encode both type and type_id so the tap handler (local notification,
      // app-in-foreground case) can route the same way handleMessage does
      // for background/terminated taps. type_id is the id of the actual
      // leave/task/etc entity — NOT the notification's own id.
      final type = message.data['type'] ?? 'notification';
      final typeId = _extractTypeId(message.data);
      final payload = jsonEncode({'type': type, 'type_id': typeId});

      await _localNotificationsPlugin.show(
        notificationId,
        title,
        body,
        notificationDetails,
        payload: payload,
      );

      log("✅ Notification shown successfully (ID: $notificationId)");
    } catch (e, stackTrace) {
      log("❌ Error showing notification: $e");
      log("❌ StackTrace: $stackTrace");
    }
  }

  Future<void> handleBackgroundNotification(RemoteMessage message) async {
    try {
      log(
        "📭 Background notification received: ${message.notification?.title}",
      );
    } catch (e) {
      log("❌ Error handling background notification: $e");
    }
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    log("🔔 Setting up notification interaction handlers...");

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      try {
        log("📲 App opened from notification (background state)");
        handleMessage(message);
      } catch (e) {
        log("❌ Error handling opened app message: $e");
      }
    });

    try {
      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        log("🚀 App launched from notification (terminated state)");
        handleMessage(initialMessage);
      } else {
        log("ℹ️ App not launched from notification");
      }
    } catch (e) {
      log("❌ Error getting initial message: $e");
    }

    log("✅ Notification interaction handlers set up");
  }

  /// Local-notification tap (app was in foreground, we showed our own
  /// notification via flutter_local_notifications).
  void _handleNotificationTap(NotificationResponse response) {
    log("👆 Notification tapped!");
    log("👆 Payload: ${response.payload}");

    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;

    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      _navigateByType(
        (data['type'] ?? '').toString(),
        (data['type_id'] ?? '').toString(),
      );
    } catch (e) {
      log("❌ Error parsing notification payload: $e");
    }
  }

  /// FCM tap (app opened from background or terminated state).
  Future<void> handleMessage(RemoteMessage message) async {
    log("📨 Handling notification message...");
    log("📨 Title: ${message.notification?.title}");
    log("📨 Data: ${message.data}");

    if (message.notification == null && message.data.isEmpty) {
      log("⚠️ Empty notification, skipping navigation");
      return;
    }

    final type = (message.data['type'] ?? '').toString();
    final typeId = _extractTypeId(message.data);

    _navigateByType(type, typeId);
  }

  /// Routes based on notification `type` + `type_id` via the shared
  /// NotificationNavigator (same logic used by the in-app notification list).
  /// Uses `rootNavigatorKey.currentContext` — NOT a manually saved context —
  /// so this works reliably even when triggered from a background/terminated
  /// FCM callback with no live widget-tree context available.
  void _navigateByType(String type, String typeId) {
    // final context = _navContext;
    // if (context == null || !context.mounted) {
    //   log(
    //     "⚠️ No valid navigator context available for navigation. "
    //         "Make sure rootNavigatorKey is passed to GoRouter(navigatorKey: ...)",
    //   );
    //   return;
    // }
    //
    // NotificationNavigator.navigate(
    //   context: context,
    //   onSwitchTab: (index) =>
    //   _ref.read(mainTabIndexProvider.notifier).state = index,
    //   type: type,
    //   typeId: typeId,
    // );
  }

  Future<void> iosForegroundMessage() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    log("✅ iOS foreground notification settings configured");
  }

  void resetUnreadCount() {
    _ref.read(unreadNotificationCountProvider.notifier).state = 0;
    log("🔄 Unread notification count reset to 0");
  }
}

import 'dart:developer';
import 'package:Doctors_App/routing/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../notification/ui/viewmodel/notification_view_model.dart';

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

  BuildContext? _savedContext;

  static const String _channelId = 'kals_360_notifications';
  static const String _channelName = 'KALS 360 Notifications';
  static const String _channelDescription = 'Notifications from KALS 360 app';

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

    // Save context for later use
    if (context != null) {
      _savedContext = context;
      log("📍 Context saved for navigation");
    }

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

    // Save context
    _savedContext = context;

    // CRITICAL: Set up the onMessage listener
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log("🔔🔔🔔 ==========================================");
        log("🔔 NOTIFICATION RECEIVED FROM FIREBASE!");
        log("🔔 Message ID: ${message.messageId}");
        log("🔔 Title: ${message.notification?.title}");
        log("🔔 Body: ${message.notification?.body}");
        log("🔔 Data: ${message.data}");
        log("🔔🔔🔔 ==========================================");
        _ref.read(notificationAlertProvider.notifier).showAlert();
        // Optional: Also refresh notification list
        _ref.invalidate(notificationViewModelProvider);

        try {
          final notification = message.notification;
          if (notification != null) {
            log("📬 Processing notification...");

            // Increment unread count using Riverpod
            final currentCount = _ref.read(unreadNotificationCountProvider);
            _ref.read(unreadNotificationCountProvider.notifier).state =
                currentCount + 1;
            log("📊 Unread count incremented to: ${currentCount + 1}");

            // Show the notification
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

      await _localNotificationsPlugin.show(
        notificationId,
        title,
        body,
        notificationDetails,
        payload: message.data.toString(),
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

    // Save context
    _savedContext = context;

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      try {
        log("📲 App opened from notification (background state)");
        // ⭐ Show alert
        _ref.read(notificationAlertProvider.notifier).showAlert();
        log("📲 Message: ${message.notification?.title}");
        handleMessage(message);
      } catch (e) {
        log("❌ Error handling opened app message: $e");
      }
    });

    // Handle when app is opened from notification (terminated state)
    try {
      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        log("🚀 App launched from notification (terminated state)");
        // ⭐ Show alert
        _ref.read(notificationAlertProvider.notifier).showAlert();
        log("🚀 Message: ${initialMessage.notification?.title}");
        handleMessage(initialMessage);
      } else {
        log("ℹ️ App not launched from notification");
      }
    } catch (e) {
      log("❌ Error getting initial message: $e");
    }

    log("✅ Notification interaction handlers set up");
  }

  void _handleNotificationTap(NotificationResponse response) {
    log("👆 Notification tapped!");
    log("👆 Payload: ${response.payload}");
    log("👆 Action ID: ${response.actionId}");

    if (_savedContext != null && _savedContext!.mounted) {
      log("✅ Navigating to notification screen...");
      _savedContext!.push(Routes.notification);
    } else {
      log("⚠️ No valid context available for navigation");
      log("⚠️ Context: $_savedContext, Mounted: ${_savedContext?.mounted}");
    }
  }

  Future<void> handleMessage(RemoteMessage message) async {
    log("📨 Handling notification message...");
    log("📨 Title: ${message.notification?.title}");
    log("📨 Data: ${message.data}");

    if (message.notification == null && message.data.isEmpty) {
      log("⚠️ Empty notification, skipping navigation");
      return;
    }

    if (_savedContext != null && _savedContext!.mounted) {
      log("✅ Navigating to notification screen...");
      _savedContext!.push(Routes.notification);
    } else {
      log("⚠️ No valid context available for navigation");
      log("⚠️ Context: $_savedContext, Mounted: ${_savedContext?.mounted}");
    }
  }

  Future<void> iosForegroundMessage() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    log("✅ iOS foreground notification settings configured");
  }

  // Method to reset unread count
  void resetUnreadCount() {
    _ref.read(unreadNotificationCountProvider.notifier).state = 0;
    log("🔄 Unread notification count reset to 0");
  }
}

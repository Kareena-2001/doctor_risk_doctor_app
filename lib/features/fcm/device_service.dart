import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceService {
  static Future<String?> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (kIsWeb) {
        final webInfo = await deviceInfo.webBrowserInfo;

        return '${webInfo.browserName.name}_${webInfo.userAgent ?? ''}';
      }

      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final androidInfo = await deviceInfo.androidInfo;
          return androidInfo.id;

        case TargetPlatform.iOS:
          final iosInfo = await deviceInfo.iosInfo;
          return iosInfo.identifierForVendor;

        default:
          return null;
      }
    } catch (e) {
      debugPrint("Device ID error: $e");
      return null;
    }
  }
}
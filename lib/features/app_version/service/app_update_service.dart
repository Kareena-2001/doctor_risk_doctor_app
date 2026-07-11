import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateService {
  // static List<int> _parseVersion(String version) {
  //   return version.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  // }

  // static bool needsForceUpdate(String currentVersion) {
  //   return isUpdateRequired(currentVersion);
  // }
  //
  // static bool hasOptionalUpdate(String currentVersion, String latestVersion) {
  //   return isUpdateRequired(currentVersion) &&
  //       !needsForceUpdate(currentVersion);
  // }

  static Future<void> openStore(String? storeUrl) async {
    final url = storeUrl ?? _getDefaultStoreUrl();
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static String _getDefaultStoreUrl() {
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=com.mobisoftseo.kals_360';
    } else if (Platform.isIOS) {
      return 'https://apps.apple.com/app/id YOUR_APP_ID';
    }
    return '';
  }

  static Future<String> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}

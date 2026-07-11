import 'package:Doctors_App/features/app_version/repository/app_version_repository.dart';
import 'package:Doctors_App/features/app_version/service/app_update_service.dart';
import 'package:Doctors_App/features/app_version/ui/widgets/update_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/values/app_constants.dart';

class AppUpdateChecker {
  static Future<bool> checkForUpdate(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final repository = ref.read(appVersionRepositoryProvider);
      final versionResponse = await repository.checkForUpdate();
      final versionData = versionResponse.data;

      if (!versionData.showUpdateModal) return false;

      final needsForceUpdate = versionData.forceUpdate;

      if (!context.mounted) return false;

      await showModalBottomSheet(
        context: context,
        isDismissible: !needsForceUpdate,
        enableDrag: !needsForceUpdate,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => UpdateBottomSheet(
          title: versionData.updateTitle?.isNotEmpty == true
              ? versionData.updateTitle!
              : 'Update Available',
          message: versionData.updateMessage?.isNotEmpty == true
              ? versionData.updateMessage!
              : 'A new version of the app is available.',
          whatsNew: versionData.whatsNew,
          isForceUpdate: needsForceUpdate,
          onUpdate: () async {
            await AppUpdateService.openStore(AppConstants.playStore);
          },
          onSkip: needsForceUpdate ? null : () => Navigator.pop(context),
        ),
      );

      return needsForceUpdate;
    } catch (e) {
      debugPrint('Error checking for update: $e');
      return false;
    }
  }
}

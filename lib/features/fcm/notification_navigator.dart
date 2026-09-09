// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../core/navigation/main_tab_state.dart';
// import '../../../routing/routes.dart';
//
// class NotificationNavigator {
//   NotificationNavigator._();
//
//   static void navigate({
//     required BuildContext context,
//     required void Function(int tabIndex) onSwitchTab,
//     required String type,
//     String? typeId,
//   }) {
//     if (!context.mounted) return;
//
//     final lowerType = type.toLowerCase();
//
//     if (lowerType.contains('leave')) {
//       onSwitchTab(leaveTabIndex);
//       context.go(Routes.main);
//       return;
//     }
//
//     if (lowerType.contains('attendance')) {
//       onSwitchTab(attendanceTabIndex);
//       context.go(Routes.main);
//       return;
//     }
//
//     if (lowerType.contains('task')) {
//       if (typeId != null && typeId.isNotEmpty) {
//         context.push(Routes.task);
//       } else {
//         onSwitchTab(homeTabIndex);
//         context.go(Routes.main);
//       }
//       return;
//     }
//     if (lowerType.contains('announcement')) {
//       // No id-wise announcement detail screen exists — always go to the list.
//       context.push(Routes.announcementScreen);
//       return;
//     }
//
//     context.push(Routes.notification);
//   }
// }

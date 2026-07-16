// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// import '../../features/home/model/policy_model.dart';
//
// extension PolicyStatusExtension on PolicyStatus {
//   String get title {
//     switch (this) {
//       case PolicyStatus.active:
//         return 'Membership Active';
//
//       case PolicyStatus.expired:
//         return 'Membership Expired';
//
//       case PolicyStatus.renewal:
//         return 'Renewal Due';
//     }
//   }
//
//   Color get color {
//     switch (this) {
//       case PolicyStatus.active:
//         return Colors.green;
//
//       case PolicyStatus.expired:
//         return Colors.red;
//
//       case PolicyStatus.renewal:
//         return Colors.orange;
//     }
//   }
//
//   IconData get icon {
//     switch (this) {
//       case PolicyStatus.active:
//         return Icons.verified;
//
//       case PolicyStatus.expired:
//         return Icons.cancel;
//
//       case PolicyStatus.renewal:
//         return Icons.refresh;
//     }
//   }
//
//   bool get showRenewButton {
//     return this != PolicyStatus.active;
//   }
// }
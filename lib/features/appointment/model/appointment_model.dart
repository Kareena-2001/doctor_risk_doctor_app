import 'package:flutter/material.dart';

import '../../profile/model/certificate_model.dart';

enum AppointmentMode { videoCall, phoneCall, inPerson }

extension AppointmentModeX on AppointmentMode {
  String get label {
    switch (this) {
      case AppointmentMode.videoCall:
        return 'Video Call';
      case AppointmentMode.phoneCall:
        return 'Phone Call';
      case AppointmentMode.inPerson:
        return 'In Person';
    }
  }

  IconData get icon {
    switch (this) {
      case AppointmentMode.videoCall:
        return Icons.videocam_outlined;
      case AppointmentMode.phoneCall:
        return Icons.call_outlined;
      case AppointmentMode.inPerson:
        return Icons.person_pin_circle_outlined;
    }
  }

  static AppointmentMode fromLabel(String label) {
    return AppointmentMode.values.firstWhere(
      (m) => m.label == label,
      orElse: () => AppointmentMode.videoCall,
    );
  }
}

class AppointmentModel {
  final String id;
  final AppointmentMode mode;
  final DateTime date;
  final TimeOfDay time;
  final String subject;
  final String description;
  final List<CertificateModel> attachments;
  final String status;

  AppointmentModel({
    required this.id,
    required this.mode,
    required this.date,
    required this.time,
    required this.subject,
    this.description = '',
    this.attachments = const [],
    this.status = 'Upcoming',
  });
}

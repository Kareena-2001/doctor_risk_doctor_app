import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../profile/model/certificate_model.dart';
import '../model/appointment_model.dart';

class AppointmentNotifier extends StateNotifier<List<AppointmentModel>> {
  // Pass the mock data array directly into super() instead of super([])
  AppointmentNotifier() : super(_mockAppointments);

  void addAppointment(AppointmentModel appointment) {
    state = [...state, appointment];
  }

  void cancelAppointment(String id) {
    state = [
      for (final a in state)
        if (a.id == id)
          AppointmentModel(
            id: a.id,
            mode: a.mode,
            date: a.date,
            time: a.time,
            subject: a.subject,
            description: a.description,
            attachments: a.attachments,
            status: 'Cancelled',
          )
        else
          a,
    ];
  }
}

final List<AppointmentModel> _mockAppointments = [
  AppointmentModel(
    id: '1',
    mode: AppointmentMode.phoneCall,
    date: DateTime.now().add(const Duration(days: 1)),
    time: const TimeOfDay(hour: 10, minute: 30),
    subject: 'Policy Plan Explanation',
    description: 'Regarding the Policy Plan ',
    attachments: [CertificateModel(name: 'report.pdf', id: '1')],
    status: 'Upcoming',
  ),
  AppointmentModel(
    id: '2',
    mode: AppointmentMode.videoCall,
    date: DateTime.now().subtract(const Duration(days: 2)),
    time: const TimeOfDay(hour: 15, minute: 0),
    subject: 'Policy Plan Explanation',
    description: 'Regarding the Policy Plan ',
    attachments: [],
    status: 'Completed',
  ),
  AppointmentModel(
    id: '3',
    mode: AppointmentMode.inPerson,
    date: DateTime.now().subtract(const Duration(days: 5)),
    time: const TimeOfDay(hour: 09, minute: 15),
    subject: 'Policy Plan Explanation',
    description: 'Regarding the Policy Plan ',
    attachments: [
      CertificateModel(name: 'report.png', id: '1'),
      CertificateModel(name: 'policy.pdf', id: '2'),
    ],
    status: 'Cancelled',
  ),
];
final appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, List<AppointmentModel>>(
      (ref) => AppointmentNotifier(),
    );

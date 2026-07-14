// lib/features/appointment/provider/appointment_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/appointment_model.dart';

class AppointmentNotifier extends StateNotifier<List<AppointmentModel>> {
  AppointmentNotifier() : super([]);

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

final appointmentProvider =
StateNotifierProvider<AppointmentNotifier, List<AppointmentModel>>(
      (ref) => AppointmentNotifier(),
);
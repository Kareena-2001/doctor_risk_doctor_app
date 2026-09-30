import 'package:Doctors_App/features/appointment/model/appointment_model.dart';

class AppointmentItem {
  final int id;
  final String appointmentNo;
  final String appointmentType;
  final String? appointmentQuery;
  final String modeOfAppointment;
  final String? link;
  final String? preferredDate;
  final String? preferredTime;
  final String priority;
  final String? description;
  final String? attachment;
  final String? scheduleRequest;
  final String appointmentStatus;
  final String createdOn;

  final bool canRemark;
  final bool canReschedule;
  final bool canCancel;

  const AppointmentItem({
    required this.id,
    required this.appointmentNo,
    required this.appointmentType,
    required this.modeOfAppointment,
    required this.priority,
    required this.appointmentStatus,
    required this.createdOn,
    required this.canRemark,
    required this.canReschedule,
    required this.canCancel,
    this.appointmentQuery,
    this.link,
    this.preferredDate,
    this.preferredTime,
    this.description,
    this.attachment,
    this.scheduleRequest,
  });

  bool get isRescheduleRequested =>
      scheduleRequest != null &&
          scheduleRequest!.isNotEmpty &&
          scheduleRequest != '0';
}

extension AppointmentToItem on Appointment {
  AppointmentItem toItem() {
    final statusLower = appointmentStatus.toLowerCase().trim();
    final isClosed =
        statusLower == 'cancelled' ||
            statusLower == 'closed' ||
            statusLower == 'cancel';

    final rescheduleRequested =
        scheduleRequest != null &&
            scheduleRequest!.isNotEmpty &&
            scheduleRequest != '0';

    return AppointmentItem(
      id: id,
      appointmentNo: appointmentNo,
      appointmentType: appointmentType,
      appointmentQuery: appointmentQuery,
      modeOfAppointment: modeOfAppointment,
      link: link,
      preferredDate: preferredDate,
      preferredTime: preferredTime,
      priority: priority,
      description: description,
      attachment: attachment,
      scheduleRequest: scheduleRequest,
      appointmentStatus: appointmentStatus,
      createdOn: createdOn,
      canRemark: true,
      canReschedule: !isClosed && !rescheduleRequested,
      canCancel: !isClosed,
    );
  }
}
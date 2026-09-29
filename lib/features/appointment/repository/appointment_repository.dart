import 'package:Doctors_App/features/appointment/model/add_appointment_remark_model.dart';
import 'package:Doctors_App/features/appointment/model/appointment_create_model.dart';
import 'package:Doctors_App/features/appointment/model/appointment_model.dart';
import 'package:Doctors_App/features/appointment/model/appointment_remarks_model.dart';
import 'package:Doctors_App/features/appointment/model/cancel_appointment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../../../core/services/credentials_storage_service.dart';

part 'appointment_repository.g.dart';

@Riverpod(keepAlive: true)
AppointmentRepository appointmentRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);

  return AppointmentRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class AppointmentRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const AppointmentRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<AppointmentResponse> appointmentList({
    String? appointmentNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final formData = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (appointmentNo != null && appointmentNo.isNotEmpty) {
        formData['appointment_no'] = appointmentNo;
      }

      if (appointmentType != null && appointmentType.isNotEmpty) {
        formData['appointment_type'] = appointmentType;
      }

      if (appointmentStatus != null && appointmentStatus.isNotEmpty) {
        formData['appointment_status'] = appointmentStatus;
      }

      if (startDate != null && startDate.isNotEmpty) {
        formData['start_date'] = startDate;
      }

      if (endDate != null && endDate.isNotEmpty) {
        formData['end_date'] = endDate;
      }

      final response = await _apiClient.post(
        url: 'doctor/appointmentlist',
        formData: formData,
        includeAuth: true,
      );

      debugPrint('Appointment List RESPONSE => $response');

      if (response['status'] == true) {
        return AppointmentResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to fetch appointments';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<AppointmentRemarksResponse> appointmentRemarks({
    String? ticketNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final formData = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (ticketNo != null && ticketNo.isNotEmpty) {
        formData['ticket_no'] = ticketNo;
      }

      if (appointmentType != null && appointmentType.isNotEmpty) {
        formData['tickete_status'] = appointmentType;
      }

      if (appointmentStatus != null && appointmentStatus.isNotEmpty) {
        formData['start_date'] = appointmentStatus;
      }

      if (startDate != null && startDate.isNotEmpty) {
        formData['end_date'] = startDate;
      }

      if (endDate != null && endDate.isNotEmpty) {
        formData['page'] = endDate;
      }

      if (endDate != null && endDate.isNotEmpty) {
        formData['limit'] = endDate;
      }

      final response = await _apiClient.post(
        url: 'doctor/appointmentlist',
        formData: formData,
        includeAuth: true,
      );

      debugPrint('Appointment List RESPONSE => $response');

      if (response['status'] == true) {
        return AppointmentRemarksResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to fetch appointments';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<CancelAppointmentResponse> cancelAppointment({
    required int appointmentId,
  }) async {
    try {
      final response = await _apiClient.post(
        url: 'doctor/appointmentcancel$appointmentId',
        includeAuth: true,
      );

      debugPrint('Cancel Appointment RESPONSE => $response');

      if (response['status'] == true) {
        return CancelAppointmentResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to cancel appointment';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<CancelAppointmentResponse> rescheduleRequest({
    required String appointmentId,
  }) async {
    try {
      final response = await _apiClient.post(
        url: 'doctor/reschedulerequest',
        formData: {'appointment_id': appointmentId},
        includeAuth: true,
      );

      debugPrint('Cancel Appointment RESPONSE => $response');

      if (response['status'] == true) {
        return CancelAppointmentResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to cancel appointment';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<AppointmentCreateResponse> addAppointment({
    required String appointmentId,
  }) async {
    try {
      final response = await _apiClient.post(
        url: 'doctor/appointment',
        formData: {'appointment_id': appointmentId},
        includeAuth: true,
      );

      debugPrint('Cancel Appointment RESPONSE => $response');

      if (response['status'] == true) {
        return AppointmentCreateResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to cancel appointment';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<AddAppointmentRemarkResponse> addAppointmentRemark({
    required String appointmentId,
    required String remark,
    required String attachment,
  }) async {
    try {
      final response = await _apiClient.post(
        url: 'doctor/addappointmentremark',
        formData: {
          'appointment_id': appointmentId,
          'remark': remark,
          'attachment': attachment,
        },
        includeAuth: true,
      );

      debugPrint('Cancel Appointment RESPONSE => $response');

      if (response['status'] == true) {
        return AddAppointmentRemarkResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to cancel appointment';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }
}

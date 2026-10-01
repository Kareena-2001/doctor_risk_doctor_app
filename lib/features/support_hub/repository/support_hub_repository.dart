import 'dart:io';

import 'package:Doctors_App/core/exceptions/app_exception.dart';
import 'package:Doctors_App/core/services/credentials_storage_provider.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/support_hub/model/add_appointment_ticket_response.dart';
import 'package:Doctors_App/features/support_hub/model/add_remark_model.dart';
import 'package:Doctors_App/features/support_hub/model/cancel_support_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/service_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/ticket_remarks_model.dart';
import 'package:Doctors_App/features/support_hub/model/update_support_ticket_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Doctors_App/core/services/api_client.dart';

part 'support_hub_repository.g.dart';

@Riverpod(keepAlive: true)
SupportHubRepository supportHubRepository(SupportHubRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return SupportHubRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class SupportHubRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const SupportHubRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<SupportTicketResponse> addSupportTicket({
    required String ticketType,
    required String queryType,
    required String commonQuery,
    required String preferredContact,
    required String priority,
    required String description,
    required String legalType,
    File? file,
  }) async {
    try {
      final Map<String, String> fields = {
        'ticket_type': ticketType,
        'query_type': queryType,
        'common_query': commonQuery,
        'preferred_contact': preferredContact,
        'priority': priority,
        'description': description,
        'legal_type': legalType,
      };

      final Map<String, File> files = {};

      if (file != null) {
        files['attachment'] = file;
      }

      debugPrint('Fields:');

      fields.forEach((key, value) {
        debugPrint('  $key = $value');
      });

      if (files.isEmpty) {
        debugPrint('Files: none');
      } else {
        debugPrint('Files:');

        files.forEach((key, file) {
          debugPrint(
            '  $key → ${file.path.split('/').last} '
            '(${file.lengthSync()} bytes)',
          );
        });
      }

      final response = await _apiClient.postMultipart(
        url: 'doctor/supportticket',
        fields: fields,
        files: files,
        includeAuth: true,
      );

      debugPrint('Add Support Ticket RESPONSE => $response');

      if (response['status'] == true) {
        return SupportTicketResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to create support ticket';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }
      rethrow;
    }
  }

  Future<AddAppointmentTicketResponse> addAppointmentForm({
    required String appointmentType,
    required String appointmentQuery,
    required String modeOfAppointment,
    required String priority,
    required String description,
    required String preferredDate,
    required String preferredTime,
    File? file,
  }) async {
    try {
      final Map<String, String> fields = {
        'appointment_type': appointmentType,
        'appointment_query': appointmentQuery,
        'mode_of_appointment': modeOfAppointment,
        'priority': priority,
        'description': description,
        'preferred_date': preferredDate,
        'preferred_time': preferredTime,
      };

      final Map<String, File> files = {};

      if (file != null) {
        files['attachment'] = file;
      }

      debugPrint('Fields:');

      fields.forEach((key, value) {
        debugPrint('  $key = $value');
      });

      if (files.isEmpty) {
        debugPrint('Files: none');
      } else {
        debugPrint('Files:');

        files.forEach((key, file) {
          debugPrint(
            '  $key → ${file.path.split('/').last} '
            '(${file.lengthSync()} bytes)',
          );
        });
      }

      final response = await _apiClient.postMultipart(
        url: 'doctor/appointment',
        fields: fields,
        files: files,
        includeAuth: true,
      );

      debugPrint('Add Support Ticket RESPONSE => $response');

      if (response['status'] == true) {
        return AddAppointmentTicketResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to create support ticket';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }
      rethrow;
    }
  }

  Future<AddRemarkResponse> addSupportRemark({
    required String ticketId,
    required String remark,
    File? file,
  }) async {
    try {
      final response = await _apiClient.postMultipart(
        url: 'doctor/addremarks',
        fields: {'ticket_id': ticketId, 'remark': remark},
        files: {if (file != null) 'attachment': file},
        includeAuth: true,
      );

      if (response['status'] == true) {
        return AddRemarkResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to add remark';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<UpdateSupportTicketResponse> updateSupportTicket({
    required String id,
    String? description,
    String? priority,
  }) async {
    try {
      final formData = <String, String>{};

      if (description != null && description.isNotEmpty) {
        formData['description'] = description;
      }

      if (priority != null && priority.isNotEmpty) {
        formData['priority'] = priority;
      }

      final response = await _apiClient.post(
        url: 'doctor/updatesupportticket/$id',
        formData: formData,
        includeAuth: true,
      );

      debugPrint('Appointment List RESPONSE => $response');

      if (response['status'] == true) {
        return UpdateSupportTicketResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to fetch appointments';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<ServiceTicketResponse> serviceTicketList({
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
        formData['appointment_type'] = appointmentType;
      }

      if (appointmentStatus != null && appointmentStatus.isNotEmpty) {
        formData['tickete_status'] = appointmentStatus;
      }

      if (startDate != null && startDate.isNotEmpty) {
        formData['start_date'] = startDate;
      }

      if (endDate != null && endDate.isNotEmpty) {
        formData['end_date'] = endDate;
      }

      final response = await _apiClient.get(
        url: 'doctor/serviceticketlist',
        queryParams: formData,
        includeAuth: true,
      );

      debugPrint('Appointment List RESPONSE => $response');

      if (response['status'] == true) {
        return ServiceTicketResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to fetch appointments';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<LegalTicketResponse> legalTicketList({
    required String id,
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
        formData['appointment_type'] = appointmentType;
      }

      if (appointmentStatus != null && appointmentStatus.isNotEmpty) {
        formData['tickete_status'] = appointmentStatus;
      }

      if (startDate != null && startDate.isNotEmpty) {
        formData['start_date'] = startDate;
      }

      if (endDate != null && endDate.isNotEmpty) {
        formData['end_date'] = endDate;
      }

      final response = await _apiClient.get(
        url: 'doctor/legalticketlist/$id',
        queryParams: formData,
        includeAuth: true,
      );

      debugPrint('Appointment List RESPONSE => $response');

      if (response['status'] == true) {
        return LegalTicketResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to fetch appointments';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<TicketRemarksResponse> supportTicketRemarks({
    required String id,
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
        formData['appointment_type'] = appointmentType;
      }

      if (appointmentStatus != null && appointmentStatus.isNotEmpty) {
        formData['tickete_status'] = appointmentStatus;
      }

      if (startDate != null && startDate.isNotEmpty) {
        formData['start_date'] = startDate;
      }

      if (endDate != null && endDate.isNotEmpty) {
        formData['end_date'] = endDate;
      }

      final response = await _apiClient.get(
        url: 'doctor/supportticketremarks/$id',
        queryParams: formData,
        includeAuth: true,
      );

      debugPrint('Appointment List RESPONSE => $response');

      if (response['status'] == true) {
        return TicketRemarksResponse.fromJson(response);
      }

      throw response['msg'] ?? 'Failed to fetch appointments';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }

      rethrow;
    }
  }

  Future<CancelSupportTicketResponse> cancelAppointment({
    required int supportId,
  }) async {
    try {
      final response = await _apiClient.post(
        url: 'doctor/supportticketcancel/$supportId',
        includeAuth: true,
      );

      debugPrint('Cancel Appointment RESPONSE => $response');

      if (response['status'] == true) {
        return CancelSupportTicketResponse.fromJson(response);
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

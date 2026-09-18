import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_provider.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/events/model/add_collaboration_response.dart';
import 'package:Doctors_App/features/events/model/collaboration_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_repository.g.dart';

@Riverpod(keepAlive: true)
EventsRepository eventsRepository(EventsRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return EventsRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class EventsRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const EventsRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<AddCollaborationResponse> addCollaboration({
    required String collaborationTarget,
    required String fullName,
    String? emailId,
    required String mobileNo,
    required String organisation,

    String? modeOfEvent,
    String? preferredDate,
    String? preferredTime,

    String? stateId,
    String? cityId,
    String? area,
    String? purpose,
  }) async {
    final response = await _apiClient.post(
      url: 'doctor/addcollabration',
      formData: {
        'collabration_target': collaborationTarget,
        'full_name': fullName,
        'email_id': emailId ?? '',
        'mobile_no': mobileNo,
        'organization': organisation,
        'mode_of_event': modeOfEvent ?? '',
        'prefered_date': preferredDate ?? '',
        'prefered_time': preferredTime ?? '',
        'state_id': stateId ?? '',
        'city_id': cityId ?? '',
        'area': area ?? '',
        'purpose': purpose ?? '',
      },
      includeAuth: true,
    );

    return AddCollaborationResponse.fromJson(response);
  }

  Future<CollaborationResponse> collaborationList() async {
    final response = await _apiClient.post(
      url: 'doctor/collaborationList',
      includeAuth: true,
    );

    return CollaborationResponse.fromJson(response);
  }
}

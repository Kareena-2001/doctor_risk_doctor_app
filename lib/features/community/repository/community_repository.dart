import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_provider.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/community/model/peer_forum_response.dart';
import 'package:Doctors_App/features/community/model/testimonial_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_repository.g.dart';

@Riverpod(keepAlive: true)
CommunityRepository communityRepository(CommunityRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return CommunityRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class CommunityRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const CommunityRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<PeerForumResponse> getAllPeerForumList() async {
    final response = await _apiClient.get(
      url: 'doctor/peerforumlist',
      includeAuth: true,
    );

    return PeerForumResponse.fromJson(response);
  }

  Future<TestimonialResponse> getAllTestimonialList() async {
    final response = await _apiClient.get(
      url: 'doctor/testimoniallist',
      includeAuth: true,
    );

    return TestimonialResponse.fromJson(response);
  }
}

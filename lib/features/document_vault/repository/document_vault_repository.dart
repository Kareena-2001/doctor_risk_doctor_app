// import 'package:Doctors_App/features/change_password/model/change_password_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../../../core/exceptions/app_exception.dart';
// import '../../../core/services/api_client.dart';
// import '../../../core/services/credentials_storage_provider.dart';
// import '../../../core/services/credentials_storage_service.dart';
//
// part 'document_vault_repository.g.dart';
//
// @Riverpod(keepAlive: true)
// DocumentVaultRepository documentVaultRepository(Ref ref) {
//   final apiClient = ref.watch(apiClientProvider);
//   final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
//   return DocumentVaultRepository(
//     apiClient: apiClient,
//     credentialsStorage: credentialsStorage,
//   );
// }
//
// class DocumentVaultRepository {
//   final ApiClient _apiClient;
//   final CredentialsStorageService _credentialsStorage;
//
//   const DocumentVaultRepository({
//     required ApiClient apiClient,
//     required CredentialsStorageService credentialsStorage,
//   }) : _apiClient = apiClient,
//         _credentialsStorage = credentialsStorage;
//
//   Future<ChangePasswordResponse> getDocumentVault({
//     required String oldPassword,
//     required String newPassword,
//     required String confirmNewPassword,
//   }) async {
//     try {
//       final response = await _apiClient.post(
//         url: 'doctor/change-password',
//         formData: {
//           'current_password': oldPassword,
//           'new_password': newPassword,
//           'confirmation_password': confirmNewPassword,
//         },
//         includeAuth: true,
//       );
//       debugPrint('Change Password RESPONSE => $response');
//
//       if (response['status'] == true) {
//         return ChangePasswordResponse.fromJson(response);
//       }
//       throw response['msg'] ?? 'Change password failed';
//     } catch (e) {
//       if (e is ApiException) {
//         throw e.message;
//       }
//       rethrow;
//     }
//   }
// }

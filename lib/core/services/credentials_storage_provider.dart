import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'credentials_storage_service.dart';

part 'credentials_storage_provider.g.dart';

@Riverpod(keepAlive: true)
CredentialsStorageService credentialsStorageService(
  CredentialsStorageServiceRef ref,
) {
  return CredentialsStorageService();
}

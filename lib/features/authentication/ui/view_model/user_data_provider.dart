import 'package:Doctors_App/features/authentication/model/authentication_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/authentication_repository.dart';

part 'user_data_provider.g.dart';

@riverpod
Future<Customer?> userData(UserDataRef ref) async {
  final repo = ref.watch(authenticationRepositoryProvider);
  return await repo.getUserData();
}

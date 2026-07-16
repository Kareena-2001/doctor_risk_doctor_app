import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/blog_model.dart';
import '../../repository/delete_repository.dart';

part 'delete_view_model.g.dart';

@riverpod
class DeleteViewModel extends _$DeleteViewModel {
  @override
  Future<DeleteAcResponse?> build() async => null;

  Future<DeleteAcResponse> deleteAccount() async {
    state = const AsyncLoading();

    final repository = ref.read(deleteRepositoryProvider);
    final response = await repository.deleteAccount();

    state = AsyncData(response);
    return response;
  }
}

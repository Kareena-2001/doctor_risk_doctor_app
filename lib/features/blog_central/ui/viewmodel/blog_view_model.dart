import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/blog_model.dart';
import '../../repository/blog_repository.dart';

part 'blog_view_model.g.dart';

@riverpod
class BlogViewModel extends _$BlogViewModel {
  @override
  Future<DeleteAcResponse?> build() async => null;

  Future<DeleteAcResponse> deleteAccount() async {
    state = const AsyncLoading();

    final repository = ref.read(blogRepositoryProvider);
    final response = await repository.deleteAccount();

    state = AsyncData(response);
    return response;
  }
}

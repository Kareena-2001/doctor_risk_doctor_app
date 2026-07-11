import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../repository/admin_docs_repository.dart';
import '../state/admin_docs_state.dart';

part 'admin_docs_view_model.g.dart';

@riverpod
class AdminDocsViewModel extends _$AdminDocsViewModel {
  @override
  FutureOr<AdminDocsState> build() async {
    return _loadDocs();
  }

  Future<AdminDocsState> _loadDocs() async {
    try {
      final repository = ref.read(adminDocsRepositoryProvider);
      final response = await repository.getAdminAssignedDocs();

      return AdminDocsState(isLoading: false, docs: response.data, error: null);
    } catch (e) {
      return AdminDocsState(isLoading: false, docs: [], error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadDocs());
  }
}

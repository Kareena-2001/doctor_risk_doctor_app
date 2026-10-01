import 'dart:async';

import 'package:Doctors_App/features/faq/repository/faq_repository.dart';
import 'package:Doctors_App/features/faq/ui/state/faq_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'faq_view_model.g.dart';

@Riverpod(keepAlive: true)
class FaqViewModel extends _$FaqViewModel {
  int _currentPage = 1;
  int _lastPage = 1;
  bool _loadingMore = false;

  bool get hasMore => _currentPage < _lastPage;
  bool get isLoadingMore => _loadingMore;

  @override
  FutureOr<FaqState> build() {
    return const FaqState();
  }

  Future<void> faqList() async {
    _loadingMore = false;
    _currentPage = 1;
    state = const AsyncLoading();

    try {
      final repository = ref.read(faqRepositoryProvider);

      final response = await repository.faqList(page: 1);

      _currentPage = response.currentPage;
      _lastPage = response.lastPage;
      state = AsyncData(
        FaqState(
          faqs: response.data,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> loadMoreFaqs() async {
    final current = state.valueOrNull;
    if (current == null || !hasMore || _loadingMore) return;

    _loadingMore = true;
    try {
      final response = await ref
          .read(faqRepositoryProvider)
          .faqList(page: _currentPage + 1);
      _currentPage = response.currentPage;
      _lastPage = response.lastPage;
      state = AsyncData(FaqState(faqs: [...current.faqs, ...response.data]));
    } finally {
      _loadingMore = false;
    }
  }
}
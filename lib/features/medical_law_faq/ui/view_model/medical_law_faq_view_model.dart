import 'dart:async';

import 'package:Doctors_App/features/medical_law_faq/repository/medical_law_faq_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/medical_law_faq_state.dart';

part 'medical_law_faq_view_model.g.dart';

@Riverpod(keepAlive: true)
class MedicalLawFaqViewModel extends _$MedicalLawFaqViewModel {
  int _currentPage = 1;
  int _lastPage = 1;
  bool _loadingMore = false;
  int _requestId = 0;

  bool get hasMore => _currentPage < _lastPage;
  bool get isLoadingMore => _loadingMore;

  @override
  FutureOr<MedicalLawFaqState> build() {
    return const MedicalLawFaqState();
  }

  Future<void> medicalLawFaqList() async {
    final requestId = ++_requestId;
    _loadingMore = false;
    _currentPage = 1;
    state = const AsyncLoading();

    try {
      final repository = ref.read(medicalLawFaqRepositoryProvider);
      final response = await repository.medicalFaqList(page: 1);
      if (requestId != _requestId) return;
      _currentPage = response.currentPage;
      _lastPage = response.lastPage;
      state = AsyncData(MedicalLawFaqState(faqs: response.data));
    } catch (error, stackTrace) {
      if (requestId != _requestId) return;
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> loadMoreMedicalFaqs() async {
    final current = state.valueOrNull;
    if (current == null || !hasMore || _loadingMore) return;

    _loadingMore = true;
    final requestId = _requestId;
    try {
      final response = await ref
          .read(medicalLawFaqRepositoryProvider)
          .medicalFaqList(page: _currentPage + 1);
      if (requestId != _requestId) return;
      _currentPage = response.currentPage;
      _lastPage = response.lastPage;
      state = AsyncData(
        MedicalLawFaqState(faqs: [...current.faqs, ...response.data]),
      );
    } finally {
      if (requestId == _requestId) _loadingMore = false;
    }
  }
}

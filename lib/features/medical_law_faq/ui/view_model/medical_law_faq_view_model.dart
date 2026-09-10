import 'dart:async';

import 'package:Doctors_App/features/medical_law_faq/repository/medical_law_faq_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/medical_law_faq_state.dart';

part 'medical_law_faq_view_model.g.dart';

@Riverpod(keepAlive: true)
class MedicalLawFaqViewModel extends _$MedicalLawFaqViewModel {
  @override
  FutureOr<MedicalLawFaqState> build() {
    return const MedicalLawFaqState();
  }

  Future<void> medicalLawFaqList() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(medicalLawFaqRepositoryProvider);
      final response = await repository.medicalFaqList();
      state = AsyncData(MedicalLawFaqState(faqs: response.data));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

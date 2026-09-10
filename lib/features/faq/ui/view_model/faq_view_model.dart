import 'dart:async';

import 'package:Doctors_App/features/faq/repository/faq_repository.dart';
import 'package:Doctors_App/features/faq/ui/state/faq_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'faq_view_model.g.dart';

@Riverpod(keepAlive: true)
class FaqViewModel extends _$FaqViewModel {
  @override
  FutureOr<FaqState> build() {
    return const FaqState();
  }

  Future<void> faqList() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(faqRepositoryProvider);

      final response = await repository.faqList();

      state = AsyncData(
        FaqState(
          faqs: response.data,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
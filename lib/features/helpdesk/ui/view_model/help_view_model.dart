import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../repository/help_repository.dart';
import '../state/help_state.dart';

part 'help_view_model.g.dart';

@Riverpod(keepAlive: true)
class HelpViewModel extends _$HelpViewModel {
  @override
  HelpState build() {
    return const HelpState();
  }

  Future<void> addRequestSupport({
    required String category,
    required String question,
    required String details,
    File? userAttachment,
  }) async {
    if (details.trim().isEmpty) {
      state = state.copyWith(
        isLoading: false,
        error: 'Please enter description for your query',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final resp = await ref
          .read(helpRepositoryProvider)
          .addRequest(
            category: category,
            question: question,
            description: details,
            userAttachment: userAttachment,
          );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        tktNumber: resp.data?.ticketNumber,
      );

      await fetchQueries();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchQueries() async {
    state = state.copyWith(isFetchingQueries: true, error: null);

    try {
      final res = await ref.read(helpRepositoryProvider).fetchQueries();
      state = state.copyWith(isFetchingQueries: false, queries: res.data);
    } catch (e) {
      state = state.copyWith(isFetchingQueries: false, error: e.toString());
    }
  }

  Future<void> fetchQueryDetail(String id) async {
    state = state.copyWith(
      isFetchingQueryDetail: true,
      queryDetailError: null,
      queryDetail: null,
    );

    try {
      final res = await ref.read(helpRepositoryProvider).fetchQueryDetail(id);

      state = state.copyWith(
        isFetchingQueryDetail: false,
        queryDetail: res.data,
      );
    } catch (e) {
      state = state.copyWith(
        isFetchingQueryDetail: false,
        queryDetailError: e.toString(),
      );
    }
  }

  void resetState() {
    state = state.copyWith(isSuccess: false, error: null);
  }
}

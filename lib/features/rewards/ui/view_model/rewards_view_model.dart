import 'dart:async';

import 'package:Doctors_App/features/rewards/repository/rewards_repository.dart';
import 'package:Doctors_App/features/rewards/ui/state/rewards_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rewards_view_model.g.dart';

@Riverpod(keepAlive: true)
class RewardsViewModel extends _$RewardsViewModel {
  static const int _limit = 10;

  bool _isFetching = false;

  @override
  RewardsState build() => const RewardsState();

  /// Fresh load / pull-to-refresh (page 1).
  Future<void> loadRewards() => _fetch(refresh: true);

  /// Pagination: appends the next page.
  Future<void> loadMoreRewards() async {
    if (!state.hasMore) return;
    await _fetch(refresh: false);
  }

  Future<void> _fetch({required bool refresh}) async {
    if (_isFetching) return;
    _isFetching = true;

    final current = state.rewardsData;
    final isRefresh = refresh || current == null;
    final page = isRefresh ? 1 : current.currentPage + 1;

    state = state.copyWith(
      isLoading: isRefresh,
      isLoadingMore: !isRefresh,
      errorMessage: null,
    );

    try {
      final res = await ref
          .read(rewardsRepositoryProvider)
          .getRewardsPoints(page: page, limit: _limit);
      final data = res.data;

      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        // Latest response carries fresh totals/pagination; only the list is appended.
        rewardsData: isRefresh
            ? data
            : data.copyWith(
          rewardPoints: [...current.rewardPoints, ...data.rewardPoints],
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      _isFetching = false;
    }
  }
}
import 'package:Doctors_App/features/rewards/model/reward_points_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rewards_state.freezed.dart';

@freezed
class RewardsState with _$RewardsState {
  const RewardsState._();

  const factory RewardsState({
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    RewardPointsData? rewardsData,
    String? errorMessage,
  }) = _RewardsState;

  /// Derived from the API pagination, no separate page/hasMore tracking needed.
  bool get hasMore {
    final data = rewardsData;
    return data != null && data.currentPage < data.lastPage;
  }
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_points_model.freezed.dart';

part 'reward_points_model.g.dart';

@freezed
class RewardPointsResponse with _$RewardPointsResponse {
  const factory RewardPointsResponse({
    required bool status,
    required int code,
    required String msg,
    required RewardPointsData data,
  }) = _RewardPointsResponse;

  factory RewardPointsResponse.fromJson(Map<String, dynamic> json) =>
      _$RewardPointsResponseFromJson(json);
}

@freezed
class RewardPointsData with _$RewardPointsData {
  const factory RewardPointsData({
    @JsonKey(name: 'available_points') required int availablePoints,
    @JsonKey(name: 'total_earned_points') required int totalEarnedPoints,
    @JsonKey(name: 'total_redeemed_points') required int totalRedeemedPoints,
    @JsonKey(name: 'reward_points')
    required List<RewardPointModel> rewardPoints,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _RewardPointsData;

  factory RewardPointsData.fromJson(Map<String, dynamic> json) =>
      _$RewardPointsDataFromJson(json);
}

@freezed
class RewardPointModel with _$RewardPointModel {
  const factory RewardPointModel({
    required int id,
    @JsonKey(name: 'reward_point_type') required String rewardPointType,
    required String text,
    required int points,
    required String date,
  }) = _RewardPointModel;

  factory RewardPointModel.fromJson(Map<String, dynamic> json) =>
      _$RewardPointModelFromJson(json);
}

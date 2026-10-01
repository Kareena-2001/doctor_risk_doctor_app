import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_summary_model.freezed.dart';

part 'payment_summary_model.g.dart';

@freezed
class PaymentSummaryResponse with _$PaymentSummaryResponse {
  const factory PaymentSummaryResponse({
    required bool status,
    required int code,
    required String msg,
    required PaymentSummaryData data,
  }) = _PaymentSummaryResponse;

  factory PaymentSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentSummaryResponseFromJson(json);
}

@freezed
class PaymentSummaryData with _$PaymentSummaryData {
  const factory PaymentSummaryData({
    @JsonKey(name: 'event_id') required int eventId,
    @JsonKey(name: 'event_name') required String eventName,
    @JsonKey(name: 'event_price') required String eventPrice,
    @JsonKey(name: 'available_reward_points')
    required int availableRewardPoints,
    @JsonKey(name: 'reward_points_used') required int rewardPointsUsed,
    @JsonKey(name: 'reward_discount_amount')
    required String rewardDiscountAmount,
    @JsonKey(name: 'coupon_code') String? couponCode,
    @JsonKey(name: 'coupon_discount_amount')
    required String couponDiscountAmount,
    @JsonKey(name: 'total_amount') required String totalAmount,
  }) = _PaymentSummaryData;

  factory PaymentSummaryData.fromJson(Map<String, dynamic> json) =>
      _$PaymentSummaryDataFromJson(json);
}

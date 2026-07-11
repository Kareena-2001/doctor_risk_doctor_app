import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/product_request.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    ProductResponse? productResp,
    @Default(true) bool isPlanListSelected,
    @Default(1) int currentStep,
    @Default('') String couponMessage,
    @Default(false) bool couponSuccess,
    @Default(false) bool isApplyingCoupon,
    @Default(0.0) double originalPremium,
    @Default(0.0) double discountAmount,
    @Default(0.0) double payableAmount,
    @Default(<String>[]) List<String> premiumOptions,

  }) = _ProductState;
}

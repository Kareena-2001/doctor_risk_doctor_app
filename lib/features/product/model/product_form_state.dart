import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/product_model.dart';

part 'product_form_state.freezed.dart';

@freezed
class ProductFormState with _$ProductFormState {
  const factory ProductFormState({
    @Default(1) int currentStep,
    @Default('') String couponMessage,
    @Default(false) bool couponSuccess,
    @Default(false) bool isApplyingCoupon,
    @Default(0.0) double originalPremium,
    @Default(0.0) double discountAmount,
    @Default(0.0) double payableAmount,
    @Default([]) List<String> premiumOptions,
  }) = _ProductFormState;
}
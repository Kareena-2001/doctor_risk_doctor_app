import 'package:Doctors_App/features/faq/model/faq_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_state.freezed.dart';

@freezed
class FaqState with _$FaqState {
  const factory FaqState({
    @Default([]) List<FaqModel> faqs,
  }) = _FaqState;
}
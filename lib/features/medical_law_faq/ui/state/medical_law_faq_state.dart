import 'package:Doctors_App/features/faq/model/faq_response.dart';
import 'package:Doctors_App/features/medical_law_faq/model/medical_law_faq_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_law_faq_state.freezed.dart';

@freezed
class MedicalLawFaqState with _$MedicalLawFaqState {
  const factory MedicalLawFaqState({
    @Default([]) List<MedicalLawFaqModel> faqs,
  }) = _MedicalLawFaqState;
}

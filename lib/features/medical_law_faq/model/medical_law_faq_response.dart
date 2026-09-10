import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_law_faq_response.freezed.dart';

part 'medical_law_faq_response.g.dart';

@freezed
class MedicalLawFaqResponse with _$MedicalLawFaqResponse {
  const factory MedicalLawFaqResponse({
    required bool status,
    required int code,
    required String msg,
    required List<MedicalLawFaqModel> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _MedicalLawFaqResponse;

  factory MedicalLawFaqResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicalLawFaqResponseFromJson(json);
}

@freezed
class MedicalLawFaqModel with _$MedicalLawFaqModel {
  const factory MedicalLawFaqModel({
    required int id,
    required String question,
    @JsonKey(name: 'ans_description') required String answerDescription,
    required String status,
    @JsonKey(name: 'created_on') required String createdOn,
  }) = _MedicalLawFaqModel;

  factory MedicalLawFaqModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalLawFaqModelFromJson(json);
}

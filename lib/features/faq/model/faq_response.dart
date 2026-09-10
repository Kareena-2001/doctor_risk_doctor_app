import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_response.freezed.dart';
part 'faq_response.g.dart';

@freezed
class FaqResponse with _$FaqResponse {
  const factory FaqResponse({
    required bool status,
    required int code,
    required String msg,
    required List<FaqModel> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _FaqResponse;

  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);
}

@freezed
class FaqModel with _$FaqModel {
  const factory FaqModel({
    required int id,
    required String question,
    @JsonKey(name: 'ans_description') required String answerDescription,
    required String status,
    @JsonKey(name: 'added_on') required String addedOn,
  }) = _FaqModel;

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sop_response.freezed.dart';

part 'sop_response.g.dart';

@freezed
class SopResponse with _$SopResponse {
  const factory SopResponse({
    required bool status,
    required int code,
    required String msg,
    required List<SopModel> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _SopResponse;

  factory SopResponse.fromJson(Map<String, dynamic> json) =>
      _$SopResponseFromJson(json);
}

@freezed
class SopModel with _$SopModel {
  const factory SopModel({
    required int id,
    required String title,
    @JsonKey(name: 'short_description') required String shortDescription,
    @JsonKey(name: 'checklist_title') required String checklistTitle,
    @JsonKey(name: 'checklist_description')
    required String checklistDescription,
    String? sop,
    @JsonKey(name: 'download_button_visible')
    required bool downloadButtonVisible,
  }) = _SopModel;

  factory SopModel.fromJson(Map<String, dynamic> json) =>
      _$SopModelFromJson(json);
}

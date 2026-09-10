import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_advisory_model.freezed.dart';
part 'news_advisory_model.g.dart';

@freezed
class NewsAdvisoryResponse with _$NewsAdvisoryResponse {
  const factory NewsAdvisoryResponse({
    required bool status,
    required int code,
    required String msg,
    required List<NewsAdvisoryModel> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _NewsAdvisoryResponse;

  factory NewsAdvisoryResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsAdvisoryResponseFromJson(json);
}

@freezed
class NewsAdvisoryModel with _$NewsAdvisoryModel {
  const factory NewsAdvisoryModel({
    required int id,
    @JsonKey(name: 'news_source') required String newsSource,
    @JsonKey(name: 'source_date') required String sourceDate,
    required String title,
    required String description,
    @JsonKey(name: 'source_url') required String sourceUrl,
    required String status,
    @JsonKey(name: 'created_on') required String createdOn,
  }) = _NewsAdvisoryModel;

  factory NewsAdvisoryModel.fromJson(Map<String, dynamic> json) =>
      _$NewsAdvisoryModelFromJson(json);
}
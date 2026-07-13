import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_advisory_model.freezed.dart';
part 'news_advisory_model.g.dart';

@freezed
class NewsAdvisoryResponse with _$NewsAdvisoryResponse {
  const factory NewsAdvisoryResponse({
    required int status,
    required String msg,
  }) = _NewsAdvisoryResponse;

  factory NewsAdvisoryResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsAdvisoryResponseFromJson(json);
}
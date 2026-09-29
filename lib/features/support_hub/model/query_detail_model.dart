import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_detail_model.freezed.dart';

part 'query_detail_model.g.dart';

@freezed
class QueryDetailModel with _$QueryDetailModel {
  const factory QueryDetailModel({
    required int status,
    required String msg,
    required QueryDetailItem data,
  }) = _QueryDetailModel;

  factory QueryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$QueryDetailModelFromJson(json);
}

@freezed
class QueryDetailItem with _$QueryDetailItem {
  const factory QueryDetailItem({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'tkt_number') required String ticketNumber,
    required String category,
    required String question,
    required String description,
    @JsonKey(name: 'tkt_status') required String ticketStatus,
    @JsonKey(name: 'query_submit') required String querySubmit,
    String? replied,
    @JsonKey(name: 'replied_date') String? repliedDate,
    @JsonKey(name: 'reply_attachment') String? replyAttachment,
    @JsonKey(name: 'user_attachment') String? userAttachment,
  }) = _QueryDetailItem;

  factory QueryDetailItem.fromJson(Map<String, dynamic> json) =>
      _$QueryDetailItemFromJson(json);
}

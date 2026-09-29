import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_list_model.freezed.dart';

part 'query_list_model.g.dart';

@freezed
class QueryListModel with _$QueryListModel {
  const factory QueryListModel({
    required int status,
    required String msg,
    @Default([]) List<QueryListItem> data,
  }) = _QueryListModel;

  factory QueryListModel.fromJson(Map<String, dynamic> json) =>
      _$QueryListModelFromJson(json);
}

@freezed
class QueryListItem with _$QueryListItem {
  const factory QueryListItem({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'tkt_number') required String ticketNumber,
    required String category,
    required String question,
    required String description,
    @JsonKey(name: 'tkt_status') required String ticketStatus,
    @JsonKey(name: 'query_submit') required String querySubmit,
  }) = _QueryListItem;

  factory QueryListItem.fromJson(Map<String, dynamic> json) =>
      _$QueryListItemFromJson(json);
}

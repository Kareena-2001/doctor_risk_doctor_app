import 'package:freezed_annotation/freezed_annotation.dart';

part 'peer_forum_response.freezed.dart';

part 'peer_forum_response.g.dart';

@freezed
class PeerForumResponse with _$PeerForumResponse {
  const factory PeerForumResponse({
    required bool status,
    required int code,
    required String msg,
    @Default([]) List<PeerForumModel> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _PeerForumResponse;

  factory PeerForumResponse.fromJson(Map<String, dynamic> json) =>
      _$PeerForumResponseFromJson(json);
}

@freezed
class PeerForumModel with _$PeerForumModel {
  const factory PeerForumModel({
    required int id,
    required String type,

    @JsonKey(name: 'type_label') required String typeLabel,

    required String title,
    required String description,

    String? image,
    String? source,

    @JsonKey(name: 'source_url') String? sourceUrl,

    String? date,

    @JsonKey(name: 'created_on') String? createdOn,

    @JsonKey(name: 'days_ago') int? daysAgo,

    @JsonKey(name: 'days_ago_label') String? daysAgoLabel,

    String? author,
    String? degree,

    @JsonKey(name: 'category_name') String? categoryName,

    @JsonKey(name: 'speciality_name') String? specialityName,
  }) = _PeerForumModel;

  factory PeerForumModel.fromJson(Map<String, dynamic> json) =>
      _$PeerForumModelFromJson(json);
}

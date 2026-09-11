import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_list_detail.freezed.dart';

part 'blog_list_detail.g.dart';

@freezed
class BlogListDetail with _$BlogListDetail {
  const factory BlogListDetail({
    required bool status,
    required int code,
    required String msg,
    required List<BlogData> data,
  }) = _BlogListDetail;

  factory BlogListDetail.fromJson(Map<String, dynamic> json) =>
      _$BlogListDetailFromJson(json);
}

@freezed
class BlogData with _$BlogData {
  const factory BlogData({
    required int id,
    required String title,
    required String description,
    required String image,
    @JsonKey(name: 'dr_name') required String drName,
    required String degree,
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'speciality_id') required int specialityId,
    @JsonKey(name: 'view_count') required int viewCount,
    @JsonKey(name: 'created_on') required String createdOn,
    @JsonKey(name: 'approve_date') required String? approveDate,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'speciality_name') required String specialityName,
    required List<KeywordData> keywords,
  }) = _BlogData;

  factory BlogData.fromJson(Map<String, dynamic> json) =>
      _$BlogDataFromJson(json);
}

@freezed
class KeywordData with _$KeywordData {
  const factory KeywordData({
    @JsonKey(name: 'blog_id') required int blogId,
    required String keyword,
  }) = _KeywordData;

  factory KeywordData.fromJson(Map<String, dynamic> json) =>
      _$KeywordDataFromJson(json);
}

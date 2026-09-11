import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_list_detail.freezed.dart';
part 'blog_list_detail.g.dart';

@freezed
class BlogListDetail with _$BlogListDetail {
  const factory BlogListDetail({
    bool? status,
    int? code,
    String? msg,
    @Default([]) List<BlogData> data,
  }) = _BlogListDetail;

  factory BlogListDetail.fromJson(Map<String, dynamic> json) =>
      _$BlogListDetailFromJson(json);
}

@freezed
class BlogData with _$BlogData {
  const factory BlogData({
    required int id,
    @Default('') String title,
    @Default('') String description,
    String? image,
    @JsonKey(name: 'dr_name') String? drName,
    String? degree,
    @JsonKey(name: 'category_id') dynamic categoryId,
    @JsonKey(name: 'speciality_id') dynamic specialityId,
    @JsonKey(name: 'view_count') dynamic viewCount,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'approve_date') String? approveDate,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    @Default([]) List<KeywordData> keywords,
  }) = _BlogData;

  factory BlogData.fromJson(Map<String, dynamic> json) =>
      _$BlogDataFromJson(json);
}

@freezed
class KeywordData with _$KeywordData {
  const factory KeywordData({
    @JsonKey(name: 'blog_id') int? blogId,
    @Default('') String keyword,
  }) = _KeywordData;

  factory KeywordData.fromJson(Map<String, dynamic> json) =>
      _$KeywordDataFromJson(json);
}
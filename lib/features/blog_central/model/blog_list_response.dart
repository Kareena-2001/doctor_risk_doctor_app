import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_list_response.freezed.dart';
part 'blog_list_response.g.dart';

@freezed
class BlogListResponse with _$BlogListResponse{
  const factory BlogListResponse({
    required bool status,
    required int code,
    required String msg,
    required List<BlogData> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _BlogListResponse;

  factory BlogListResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogListResponseFromJson(json);
}

@freezed
class BlogData with _$BlogData {
  const factory BlogData({
    required int id,
    required String title,
    @JsonKey(name: 'dr_name') required String drName,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'speciality_name') required String specialityName,
    required String degree,
    @JsonKey(name: 'view_count') required String viewCount,
    required String? date,
    required List<String> keywords,
  }) = _BlogData;

  factory BlogData.fromJson(Map<String, dynamic> json) =>
      _$BlogDataFromJson(json);
}
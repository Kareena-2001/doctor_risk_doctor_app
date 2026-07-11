import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_request.freezed.dart';

part 'product_request.g.dart';

@freezed
class ProductRequest with _$ProductRequest{
  const factory ProductRequest({required String email}) =
      _ProductRequest;

  factory ProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestFromJson(json);
}

@freezed
class ProductResponse with _$ProductResponse {
  const factory ProductResponse({
    required int status,
    required String message,
    required List<dynamic> data,
  }) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
}

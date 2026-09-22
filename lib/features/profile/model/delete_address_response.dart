import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_address_response.freezed.dart';
part 'delete_address_response.g.dart';

@freezed
class DeleteAddressResponse with _$DeleteAddressResponse {
  const factory DeleteAddressResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _DeleteAddressResponse;

  factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteAddressResponseFromJson(json);
}
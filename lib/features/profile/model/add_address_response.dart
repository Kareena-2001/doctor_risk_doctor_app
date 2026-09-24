import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_address_response.freezed.dart';
part 'add_address_response.g.dart';

@freezed
class AddAddressResponse with _$AddAddressResponse {
  const factory AddAddressResponse({
    required bool status,
    required int code,
    required String msg,
    required AddAddressData data,
  }) = _AddAddressResponse;

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddAddressResponseFromJson(json);
}

@freezed
class AddAddressData with _$AddAddressData {
  const factory AddAddressData({
    required AddressModel address,
  }) = _AddAddressData;

  factory AddAddressData.fromJson(Map<String, dynamic> json) =>
      _$AddAddressDataFromJson(json);
}

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    required int id,

    @JsonKey(name: 'address_type')
    required String addressType,

    @JsonKey(name: 'own_visiting')
    required String ownVisiting,

    required String address1,
    required String address2,
    required String landmark,
    // required String area,
    required String state,
    required String city,
    required String pincode,

    // String? status,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

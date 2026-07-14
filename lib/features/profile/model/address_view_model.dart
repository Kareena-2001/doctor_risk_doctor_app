class AddressViewData {
  final String address1;
  final String address2;
  final String landmark;
  final String pinCode;
  final String city;
  final String state;

  const AddressViewData({
    required this.address1,
    this.address2 = '',
    this.landmark = '',
    required this.pinCode,
    required this.city,
    required this.state,
  });

  factory AddressViewData.fromJson(Map<String, dynamic> json) {
    return AddressViewData(
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      landmark: json['landmark'] ?? '',
      pinCode: json['pinCode'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
    );
  }
}
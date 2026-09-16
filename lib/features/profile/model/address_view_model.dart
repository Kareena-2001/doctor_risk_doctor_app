class AddressViewData {
  final String addressType;
  final String ownVisiting;
  final String address1;
  final String address2;
  final String landmark;
  final String area;
  final String state;
  final String city;
  final String pincode;

  const AddressViewData({
    this.addressType = '',
    this.ownVisiting = '',
    this.address1 = '',
    this.address2 = '',
    this.landmark = '',
    this.area = '',
    this.state = '',
    this.city = '',
    this.pincode = '',
  });

  factory AddressViewData.fromJson(Map<String, dynamic> json) {
    return AddressViewData(
      addressType: json['address_type'] ?? '',
      ownVisiting: json['own_visiting'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      landmark: json['landmark'] ?? '',
      area: json['area'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }
}
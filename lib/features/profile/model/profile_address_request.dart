class ProfileAddressRequest {
  final String? id;
  final String? addressType;
  final String? ownVisiting;
  final String? address1;
  final String? address2;
  final String? landmark;
  final String? area;
  final String? state;
  final String? city;
  final String? pincode;

  const ProfileAddressRequest({
    this.id,
    this.addressType,
    this.ownVisiting,
    this.address1,
    this.address2,
    this.landmark,
    this.area,
    this.state,
    this.city,
    this.pincode,
  });

  Map<String, String> toMultipartFields(int index) {
    return {
      'addresses[$index][id]': id ?? '',
      'addresses[$index][address_type]': addressType ?? '',
      'addresses[$index][own_visiting]': ownVisiting ?? '',
      'addresses[$index][address1]': address1 ?? '',
      'addresses[$index][address2]': address2 ?? '',
      'addresses[$index][landmark]': landmark ?? '',
      'addresses[$index][area]': area ?? '',
      'addresses[$index][state]': state ?? '',
      'addresses[$index][city]': city ?? '',
      'addresses[$index][pincode]': pincode ?? '',
    };
  }
}

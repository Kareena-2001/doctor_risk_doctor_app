import 'package:flutter/cupertino.dart';

class AddressFormModel {
  final TextEditingController address1 = TextEditingController();
  final TextEditingController address2 = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();

  void dispose() {
    address1.dispose();
    address2.dispose();
    landmark.dispose();
    pinCode.dispose();
    city.dispose();
    state.dispose();
  }
}
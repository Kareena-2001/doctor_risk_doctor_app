import 'address_view_model.dart';
import 'certificate_model.dart';
import 'policy_model.dart';

class DoctorProfileData {
  final String prefix;
  final String firstName;
  final String middleName;
  final String lastName;
  final String degree;
  final String category;
  final String email;
  final String mobile;
  final String? alternateMobile;
  final String organisation;
  final String speciality;
  final DateTime? dob;
  final String gender;
  final String religion;
  final List<AddressViewData> addresses;
  final List<CertificateModel> doctorCertificates;
  final List<CertificateModel> organisationCertificates;
  // final List<PolicyModel> policies;

  const DoctorProfileData({
    required this.prefix,
    required this.firstName,
    this.middleName = '',
    required this.lastName,
    required this.degree,
    this.category = '',
    required this.email,
    required this.mobile,
    this.alternateMobile,
    this.organisation = '',
    this.speciality = '',
    this.dob,
    this.gender = '',
    this.religion = '',
    this.addresses = const [],
    this.doctorCertificates = const [],
    this.organisationCertificates = const [],
    // this.policies = const [],
  });

  String get fullName => [prefix, firstName, middleName, lastName]
      .where((e) => e.trim().isNotEmpty)
      .join(' ');
}
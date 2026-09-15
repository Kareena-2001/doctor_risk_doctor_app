import 'address_view_model.dart';
import 'certificate_model.dart';

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

  final ClinicHospitalModel? clinicHospitalDetails;

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
    this.clinicHospitalDetails,
  });

  String get fullName => [
    prefix,
    firstName,
    middleName,
    lastName,
  ].where((e) => e.trim().isNotEmpty).join(' ');
}

class ClinicHospitalModel {
  final String? medicalRegState;
  final String? medicalRegNo;
  final String? medicalRegYear;
  final String? hospitalClinicRegState;
  final String? hospitalClinicRegNo;
  final String? hospitalClinicRegYear;
  final String? retroactive;
  final String? retroactiveDate;
  final String? retroactivePolicyDoc;
  final String? worldwide;
  final String? unqualifiedStaff;
  final String? unqualifiedStaffCount;
  final String? opd;
  final String? ipd;

  const ClinicHospitalModel({
    this.medicalRegState,
    this.medicalRegNo,
    this.medicalRegYear,
    this.hospitalClinicRegState,
    this.hospitalClinicRegNo,
    this.hospitalClinicRegYear,
    this.retroactive,
    this.retroactiveDate,
    this.retroactivePolicyDoc,
    this.worldwide,
    this.unqualifiedStaff,
    this.unqualifiedStaffCount,
    this.opd,
    this.ipd,
  });
}

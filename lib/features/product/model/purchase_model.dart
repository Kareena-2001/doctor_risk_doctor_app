enum Gender { male, female, other }

extension GenderX on Gender {
  String get label {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }
}

class PersonalDetails {
  final String prefix;
  final String firstName;
  final String middleName;
  final String lastName;
  final String degree;
  final String emailId;
  final String mobileNumber;
  final String alternateNumber;
  final DateTime dateOfBirth;
  final Gender gender;
  final String organisation;

  const PersonalDetails({
    required this.prefix,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.degree,
    required this.emailId,
    required this.mobileNumber,
    required this.alternateNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.organisation,
  });

  String get fullName =>
      '$prefix $firstName $middleName $lastName'.replaceAll('  ', ' ').trim();
}

class HospitalDetails {
  final String medicalRegState;
  final String medicalRegNo;
  final String medicalRegYear;
  final String? diplomaCertificatePath;
  final String? previousPolicyPath;
  final DateTime? retroactiveDate;
  final bool retroActive;
  final bool worldwide;
  final bool hasUnqualifiedStaff;
  final int unqualifiedStaffCount;

  const HospitalDetails({
    required this.medicalRegState,
    required this.medicalRegNo,
    required this.medicalRegYear,
    this.diplomaCertificatePath,
    this.previousPolicyPath,
    required this.retroactiveDate,
    required this.retroActive,
    required this.worldwide,
    required this.hasUnqualifiedStaff,
    required this.unqualifiedStaffCount,
  });
}

enum AddressType { home, clinic, hospital, office }

extension AddressTypeX on AddressType {
  String get label {
    switch (this) {
      case AddressType.home:
        return 'Residential';
      case AddressType.clinic:
        return 'Clinic';
      case AddressType.hospital:
        return 'Hospital/Clinic';
      case AddressType.office:
        return 'Office';
    }
  }
}

enum OwnOrVisiting { own, visiting }

extension OwnOrVisitingX on OwnOrVisiting {
  String get label => this == OwnOrVisiting.own ? 'Own' : 'Visiting';
}


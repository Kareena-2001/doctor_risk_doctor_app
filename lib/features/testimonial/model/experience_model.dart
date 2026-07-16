enum ExperienceType { text, video }

class ExperienceModel  {
  final String name;
  final String speciality;
  final ExperienceType experienceType;
  final String experience;
  final String addedOn;

  const ExperienceModel({
    required this.name,
    required this.speciality,
    required this.experienceType,
    required this.experience,
    required this.addedOn,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      name: json['name'] ?? '',
      speciality: json['speciality'] ?? '',
      experienceType: ExperienceType.values.firstWhere(
        (e) => e.name == json['experience_type'],
        orElse: () => ExperienceType.text,
      ),
      experience: json['experience'] ?? '',
      addedOn: json['added_on'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'speciality': speciality,
      'experience_type': experienceType.name,
      'experience': experience,
      'added_on': addedOn,
    };
  }
}

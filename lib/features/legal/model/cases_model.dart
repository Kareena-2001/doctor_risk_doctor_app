class CasesModel {
  final String id;
  final String description;
  final String complainantName;
  final String complainantNo;
  final String addedOn;
  final String updateOn;
  final String caseStatus;
  final String status;

  CasesModel({
    required this.id,
    required this.description,
    required this.complainantName,
    required this.complainantNo,
    required this.addedOn,
    required this.updateOn,
    required this.caseStatus,
    required this.status,
  });
}

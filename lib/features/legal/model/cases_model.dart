class CasesModel {
  final String id;
  final String doctorId;
  final String advocateName;
  final String complainantName;
  final String complainantNo;
  final String addedOn;
  final String updateOn;
  final String caseStatus;
  final String status;

  CasesModel({
    required this.id,
    required this.doctorId,
    required this.advocateName,
    required this.complainantName,
    required this.complainantNo,
    required this.addedOn,
    required this.updateOn,
    required this.caseStatus,
    required this.status,
  });
}

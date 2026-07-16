enum CourtCaseStatus { pending, completed, adjourned }

class CourtCaseModel {
  final int srNo;
  final String advocateName;
  final String previousDate;
  final String caseType;
  final String caseNo;
  final String complainantName;
  final String complainantMobile;
  final String court;
  final bool presentRequired;
  final String addedOn;
  final String nextDate;
  final CourtCaseStatus status;
  final List<RemarkModel> remarks;

  const CourtCaseModel({
    required this.srNo,
    required this.advocateName,
    required this.previousDate,
    required this.caseType,
    required this.caseNo,
    required this.complainantName,
    required this.complainantMobile,
    required this.court,
    required this.presentRequired,
    required this.addedOn,
    required this.nextDate,
    this.status = CourtCaseStatus.pending,
    required this.remarks,
  });

  factory CourtCaseModel.fromJson(Map<String, dynamic> json) {
    return CourtCaseModel(
      srNo: json['sr_no'] ?? 0,
      advocateName: json['advocate_name'] ?? '',
      previousDate: json['previous_date'] ?? '',
      caseType: json['case_type'] ?? '',
      caseNo: json['case_no'] ?? '',
      complainantName: json['complainant_name'] ?? '',
      complainantMobile: json['complainant_mobile'] ?? '',
      court: json['court'] ?? '',
      presentRequired: json['present_required'] ?? false,
      addedOn: json['added_on'] ?? '',
      nextDate: json['next_date'] ?? '',
      status: CourtCaseStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CourtCaseStatus.pending,
      ),
      remarks: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sr_no': srNo,
      'advocate_name': advocateName,
      'previous_date': previousDate,
      'case_type': caseType,
      'case_no': caseNo,
      'complainant_name': complainantName,
      'complainant_mobile': complainantMobile,
      'court': court,
      'present_required': presentRequired,
      'added_on': addedOn,
      'next_date': nextDate,
      'status': status.name,
      'remarks': remarks.map((x) => x.toMap()).toList(),
    };
  }
}

/// Subclass tracking an individual remark note entry along with its structural document files

class RemarkModel {
  final String remarkText;
  final String documentName;
  final String fileName;
  final String timeStamp;

  RemarkModel({
    required this.remarkText,
    required this.documentName,
    required this.fileName,
    required this.timeStamp,
  });

  RemarkModel copyWith({
    String? remarkText,
    String? documentName,
    String? fileName,
    String? timeStamp,
  }) {
    return RemarkModel(
      remarkText: remarkText ?? this.remarkText,
      documentName: documentName ?? this.documentName,
      fileName: fileName ?? this.fileName,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'remarkText': remarkText,
      'documentName': documentName,
      'fileName': fileName,
      'timeStamp': timeStamp,
    };
  }

  factory RemarkModel.fromMap(Map<String, dynamic> map) {
    return RemarkModel(
      remarkText: map['remarkText'] as String? ?? '',
      documentName: map['documentName'] as String? ?? '',
      fileName: map['fileName'] as String? ?? '',
      timeStamp: map['timeStamp'] as String? ?? '',
    );
  }
}

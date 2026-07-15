import 'dart:convert';

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

/// Core Cases tracking operational data architecture model
class CasesModel {
  final String id;
  final String noticeMode;         // 'Send' or 'Received'
  final String noticeType;         // 'Defamation', 'Recovery', 'Medical Negligence' etc.
  final String complainantName;
  final String complainantMobile;   // Replaced complainantNo to keep alignment with the view card layer
  final String place;
  final String description;
  final String status;             // Internal status tracker: 'Active', 'In-Progress', 'Closed'
  final String caseStatus;         // Extra state tracker mapping
  final List<String> uploadedFiles;// Structural primary notice attachments list
  final List<RemarkModel> remarks; // Chronological historical list logs array field tracking nested remark logs
  final String addedOn;
  final String updateOn;

  CasesModel({
    required this.id,
    required this.noticeMode,
    required this.noticeType,
    required this.complainantName,
    required this.complainantMobile,
    required this.place,
    required this.description,
    required this.status,
    required this.caseStatus,
    required this.uploadedFiles,
    required this.remarks,
    required this.addedOn,
    required this.updateOn,
  });

  CasesModel copyWith({
    String? id,
    String? noticeMode,
    String? noticeType,
    String? complainantName,
    String? complainantMobile,
    String? place,
    String? description,
    String? status,
    String? caseStatus,
    List<String>? uploadedFiles,
    List<RemarkModel>? remarks,
    String? addedOn,
    String? updateOn,
  }) {
    return CasesModel(
      id: id ?? this.id,
      noticeMode: noticeMode ?? this.noticeMode,
      noticeType: noticeType ?? this.noticeType,
      complainantName: complainantName ?? this.complainantName,
      complainantMobile: complainantMobile ?? this.complainantMobile,
      place: place ?? this.place,
      description: description ?? this.description,
      status: status ?? this.status,
      caseStatus: caseStatus ?? this.caseStatus,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
      remarks: remarks ?? this.remarks,
      addedOn: addedOn ?? this.addedOn,
      updateOn: updateOn ?? this.updateOn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'noticeMode': noticeMode,
      'noticeType': noticeType,
      'complainantName': complainantName,
      'complainantMobile': complainantMobile,
      'place': place,
      'description': description,
      'status': status,
      'caseStatus': caseStatus,
      'uploadedFiles': uploadedFiles,
      'remarks': remarks.map((x) => x.toMap()).toList(),
      'addedOn': addedOn,
      'updateOn': updateOn,
    };
  }

  factory CasesModel.fromMap(Map<String, dynamic> map) {
    return CasesModel(
      id: map['id'] as String? ?? '',
      noticeMode: map['noticeMode'] as String? ?? 'Received',
      noticeType: map['noticeType'] as String? ?? 'General Notice',
      complainantName: map['complainantName'] as String? ?? '',
      complainantMobile: map['complainantMobile'] as String? ?? map['complainantNo'] as String? ?? '',
      place: map['place'] as String? ?? '',
      description: map['description'] as String? ?? '',
      status: map['status'] as String? ?? 'Active',
      caseStatus: map['caseStatus'] as String? ?? '',
      uploadedFiles: List<String>.from(map['uploadedFiles'] as List<dynamic>? ?? []),
      remarks: map['remarks'] != null
          ? List<RemarkModel>.from((map['remarks'] as List<dynamic>).map<RemarkModel>((x) => RemarkModel.fromMap(x as Map<String,dynamic>)))
          : [],
      addedOn: map['addedOn'] as String? ?? '',
      updateOn: map['updateOn'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CasesModel.fromJson(String source) => CasesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
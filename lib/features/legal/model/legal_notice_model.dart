import 'dart:convert';

class LegalNoticeModel {
  final String id;
  final String noticeMode;         // 'Select', 'Send', 'Received'
  final String noticeType;         // 'Defamation', 'Recovery', '138 NI', 'Medical Negligence'
  final DateTime date;             // Selected Incident/Notice date
  final String complainantName;
  final String complainantMobile;
  final String place;
  final String description;
  final String status;             // Internal status tracker: 'Active', 'In-Progress', 'Closed'
  final List<String> uploadedFiles;// Document attachment name list
  final String addedOn;
  final String updateOn;

  LegalNoticeModel({
    required this.id,
    required this.noticeMode,
    required this.noticeType,
    required this.date,
    required this.complainantName,
    required this.complainantMobile,
    required this.place,
    required this.description,
    required this.status,
    required this.uploadedFiles,
    required this.addedOn,
    required this.updateOn,
  });

  /// standard helper pattern to duplicate instances while updating specific keys
  LegalNoticeModel copyWith({
    String? id,
    String? noticeMode,
    String? noticeType,
    DateTime? date,
    String? complainantName,
    String? complainantMobile,
    String? place,
    String? description,
    String? status,
    List<String>? uploadedFiles,
    String? addedOn,
    String? updateOn,
  }) {
    return LegalNoticeModel(
      id: id ?? this.id,
      noticeMode: noticeMode ?? this.noticeMode,
      noticeType: noticeType ?? this.noticeType,
      date: date ?? this.date,
      complainantName: complainantName ?? this.complainantName,
      complainantMobile: complainantMobile ?? this.complainantMobile,
      place: place ?? this.place,
      description: description ?? this.description,
      status: status ?? this.status,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
      addedOn: addedOn ?? this.addedOn,
      updateOn: updateOn ?? this.updateOn,
    );
  }

  /// Converts model object fields into a Map structural format for backend engines
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'noticeMode': noticeMode,
      'noticeType': noticeType,
      'date': date.millisecondsSinceEpoch,
      'complainantName': complainantName,
      'complainantMobile': complainantMobile,
      'place': place,
      'description': description,
      'status': status,
      'uploadedFiles': uploadedFiles,
      'addedOn': addedOn,
      'updateOn': updateOn,
    };
  }

  /// Factory tool to easily build data objects out of parsed Map data structures
  factory LegalNoticeModel.fromMap(Map<String, dynamic> map) {
    return LegalNoticeModel(
      id: map['id'] as String? ?? '',
      noticeMode: map['noticeMode'] as String? ?? 'Select',
      noticeType: map['noticeType'] as String? ?? '',
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : DateTime.now(),
      complainantName: map['complainantName'] as String? ?? '',
      complainantMobile: map['complainantMobile'] as String? ?? '',
      place: map['place'] as String? ?? '',
      description: map['description'] as String? ?? '',
      status: map['status'] as String? ?? 'Active',
      uploadedFiles: List<String>.from(map['uploadedFiles'] as List<dynamic>? ?? []),
      addedOn: map['addedOn'] as String? ?? '',
      updateOn: map['updateOn'] as String? ?? '',
    );
  }

  /// Converts model to raw JSON string representation
  String toJson() => json.encode(toMap());

  /// Decodes raw JSON string directly back into a clean CasesModel instance object
  factory LegalNoticeModel.fromJson(String source) =>
      LegalNoticeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
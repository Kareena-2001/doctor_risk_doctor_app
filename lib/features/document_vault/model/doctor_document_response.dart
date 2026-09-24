import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_document_response.freezed.dart';

part 'doctor_document_response.g.dart';

@freezed
class DoctorDocumentResponse with _$DoctorDocumentResponse {
  const factory DoctorDocumentResponse({
    required bool status,
    required int code,
    required String msg,
    required List<DoctorDocument> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _DoctorDocumentResponse;

  factory DoctorDocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDocumentResponseFromJson(json);
}

@freezed
class DoctorDocument with _$DoctorDocument {
  const factory DoctorDocument({
    int? id,
    @JsonKey(name: 'doc_name') required String docName,
    String? documents,
    required String status,
    @JsonKey(name: 'doc_type') String? docType,
  }) = _DoctorDocument;

  factory DoctorDocument.fromJson(Map<String, dynamic> json) =>
      _$DoctorDocumentFromJson(json);
}

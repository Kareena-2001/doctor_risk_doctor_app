import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_document_response.freezed.dart';

part 'company_document_response.g.dart';

@freezed
class CompanyDocumentResponse with _$CompanyDocumentResponse {
  const factory CompanyDocumentResponse({
    required bool status,
    required int code,
    required String msg,
    required List<CompanyDocument> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _CompanyDocumentResponse;

  factory CompanyDocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyDocumentResponseFromJson(json);
}

@freezed
class CompanyDocument with _$CompanyDocument {
  const factory CompanyDocument({
    required int id,
    @JsonKey(name: 'doc_name') required String docName,
    String? documents,
    required String status,
  }) = _CompanyDocument;

  factory CompanyDocument.fromJson(Map<String, dynamic> json) =>
      _$CompanyDocumentFromJson(json);
}

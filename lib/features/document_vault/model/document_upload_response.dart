import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_upload_response.freezed.dart';
part 'document_upload_response.g.dart';

@freezed
class DocumentUploadResponse with _$DocumentUploadResponse {
  const factory DocumentUploadResponse({
    required bool status,
    required int code,
    required String msg,
    required DocumentUploadData data,
  }) = _DocumentUploadResponse;

  factory DocumentUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentUploadResponseFromJson(json);
}

@freezed
class DocumentUploadData with _$DocumentUploadData {
  const factory DocumentUploadData({
    required int id,
  }) = _DocumentUploadData;

  factory DocumentUploadData.fromJson(Map<String, dynamic> json) =>
      _$DocumentUploadDataFromJson(json);
}
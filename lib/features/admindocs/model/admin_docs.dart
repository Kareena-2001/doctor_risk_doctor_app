import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_docs.freezed.dart';

part 'admin_docs.g.dart';

@freezed
class AdminDocsResponse with _$AdminDocsResponse {
  const factory AdminDocsResponse({
    required int status,
    required String msg,
    required List<AdminDocsData> data,
  }) = _AdminDocsResponse;

  factory AdminDocsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminDocsResponseFromJson(json);
}

@freezed
class AdminDocsData with _$AdminDocsData {
  const factory AdminDocsData({
    required String id,

    @JsonKey(name: 'user_id') required String userId,

    @JsonKey(name: 'letter_type') required String letterType,

    @JsonKey(name: 'file') required String fileUrl,

    @JsonKey(name: 'file_send_date') required String fileSendDate,
  }) = _AdminDocsData;

  factory AdminDocsData.fromJson(Map<String, dynamic> json) =>
      _$AdminDocsDataFromJson(json);
}

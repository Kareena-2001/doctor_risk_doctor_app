import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_model.freezed.dart';

part 'app_version_model.g.dart';

@freezed
class AppVersionResponse with _$AppVersionResponse {
  const factory AppVersionResponse({
    required int status,
    required String msg,
    required AppVersionData data,
  }) = _AppVersionResponse;

  factory AppVersionResponse.fromJson(Map<String, dynamic> json) =>
      _$AppVersionResponseFromJson(json);
}

@freezed
class AppVersionData with _$AppVersionData {
  const factory AppVersionData({
    @JsonKey(name: 'show_update_modal') required bool showUpdateModal,
    @JsonKey(name: 'force_update') required bool forceUpdate,
    @JsonKey(name: 'latest_version') required String latestVersion,
    @JsonKey(name: 'update_title') String? updateTitle,
    @JsonKey(name: 'update_message') String? updateMessage,
    @JsonKey(name: 'whats_new') String? whatsNew,
  }) = _AppVersionData;

  factory AppVersionData.fromJson(Map<String, dynamic> json) =>
      _$AppVersionDataFromJson(json);
}

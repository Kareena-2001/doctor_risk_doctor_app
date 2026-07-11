import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/admin_docs.dart';

part 'admin_docs_state.freezed.dart';

@freezed
class AdminDocsState with _$AdminDocsState {
  const factory AdminDocsState({
    @Default(false) bool isLoading,
    @Default([]) List<AdminDocsData> docs,
    String? error,
  }) = _AdminDocsState;
}

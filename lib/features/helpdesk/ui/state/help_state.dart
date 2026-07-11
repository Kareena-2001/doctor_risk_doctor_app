import 'package:freezed_annotation/freezed_annotation.dart';
import '../../model/query_detail_model.dart';
import '../../model/query_list_model.dart';

part 'help_state.freezed.dart';

@freezed
class HelpState with _$HelpState {
  const factory HelpState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? error,
    String? tktNumber,

    @Default([]) List<QueryListItem> queries,
    @Default(false) bool isFetchingQueries,

    QueryDetailItem? queryDetail,
    @Default(false) bool isFetchingQueryDetail,
    String? queryDetailError,
  }) = _HelpState;
}

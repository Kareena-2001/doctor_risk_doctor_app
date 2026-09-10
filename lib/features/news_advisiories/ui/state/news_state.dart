import 'package:Doctors_App/features/news_advisiories/model/news_advisory_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_state.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState({@Default([]) List<NewsAdvisoryModel> news}) =
      _NewsState;
}

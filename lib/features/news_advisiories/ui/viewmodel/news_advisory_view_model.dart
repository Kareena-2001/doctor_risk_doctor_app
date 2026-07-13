import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/news_advisory_model.dart';
import '../../repository/news_advisory_repository.dart';

part 'news_advisory_view_model.g.dart';

@riverpod
class NewsAdvisoryViewModel extends _$NewsAdvisoryViewModel {
  @override
  Future<NewsAdvisoryResponse?> build() async => null;


}

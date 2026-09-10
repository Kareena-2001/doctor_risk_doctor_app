import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/news_advisory_model.dart';
import '../../repository/news_advisory_repository.dart';
import '../state/news_state.dart';

part 'news_advisory_view_model.g.dart';

@Riverpod(keepAlive: true)
class NewsAdvisoryViewModel extends _$NewsAdvisoryViewModel {
  List<NewsAdvisoryModel> _allNews = [];

  @override
  FutureOr<NewsState> build() {
    return const NewsState();
  }

  Future<void> newsList() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(newsAdvisoryRepositoryProvider);

      final response = await repository.newsList();

      _allNews = response.data;

      state = AsyncData(NewsState(news: _allNews));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  void searchNews(String query) {
    final searchQuery = query.trim().toLowerCase();

    final filteredNews = searchQuery.isEmpty
        ? _allNews
        : _allNews.where((item) {
            return item.title.toLowerCase().contains(searchQuery) ||
                item.description.toLowerCase().contains(searchQuery) ||
                item.newsSource.toLowerCase().contains(searchQuery);
          }).toList();

    state = AsyncData(NewsState(news: filteredNews));
  }
}

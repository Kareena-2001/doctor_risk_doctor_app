import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/news_advisory_model.dart';
import '../../repository/news_advisory_repository.dart';
import '../state/news_state.dart';

part 'news_advisory_view_model.g.dart';

@Riverpod(keepAlive: true)
class NewsAdvisoryViewModel extends _$NewsAdvisoryViewModel {
  List<NewsAdvisoryModel> _allNews = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _loadingMore = false;
  String _searchQuery = '';
  int _requestId = 0;

  bool get hasMore => _currentPage < _lastPage;

  @override
  FutureOr<NewsState> build() {
    return const NewsState();
  }

  Future<void> newsList() async {
    final requestId = ++_requestId;
    _currentPage = 1;
    _lastPage = 1;
    _loadingMore = false;
    state = const AsyncLoading();

    try {
      final repository = ref.read(newsAdvisoryRepositoryProvider);

      final response = await repository.newsList(page: 1);
      if (requestId != _requestId) return;

      _allNews = response.data;
      _currentPage = response.currentPage;

      _lastPage = response.lastPage;

      _publishFilteredNews();
    } catch (error, stackTrace) {
      if (requestId != _requestId) return;
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> loadMoreNews() async {
    if (_loadingMore || !hasMore) return;

    _loadingMore = true;
    final requestId = _requestId;
    try {
      final response = await ref
          .read(newsAdvisoryRepositoryProvider)
          .newsList(page: _currentPage + 1);
      if (requestId != _requestId) return;
      _allNews = [..._allNews, ...response.data];
      _currentPage = response.currentPage;
      _lastPage = response.lastPage;
      _publishFilteredNews();
    } finally {
      if (requestId == _requestId) _loadingMore = false;
    }
  }

  void searchNews(String query) {
    _searchQuery = query.trim().toLowerCase();
    _publishFilteredNews();
  }

  void _publishFilteredNews() {
    final filteredNews = _searchQuery.isEmpty
        ? _allNews
        : _allNews.where((item) {
            return item.title.toLowerCase().contains(_searchQuery) ||
                item.description.toLowerCase().contains(_searchQuery) ||
                item.newsSource.toLowerCase().contains(_searchQuery);
          }).toList();

    state = AsyncData(NewsState(news: filteredNews));
  }
}

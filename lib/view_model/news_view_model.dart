import 'package:flutter/foundation.dart';
import '../../services/api_service/news_api_service.dart';
import '../../model/article.dart';
import '../../utilities/app_constants.dart';

enum SortOrder { newestFirst, oldestFirst }

class NewsViewModel extends ChangeNotifier {
  final NewsService _service = NewsService();
  final List<Article> articles = [];
  int currentPageOffset = AppConstants.defaultOffset;
  bool isLoading = false;
  bool hasMore = true;
  SortOrder sortOrder = SortOrder.newestFirst;

  Future<void> fetchArticles({bool isRefresh = false}) async {
    if (isLoading || (!hasMore && !isRefresh)) return;

    isLoading = true;

    try {
      if (isRefresh) {
        currentPageOffset = AppConstants.defaultOffset;
        articles.clear();
        hasMore = true;
      }

      // Simulate API call with delay or use actual API
      final newArticles = await _service.getArticles(
        currentPageOffset,
        AppConstants.defaultLimit,
      );

      if (newArticles.isEmpty) {
        hasMore = false;
      } else {
        articles.addAll(newArticles);
        currentPageOffset += AppConstants.defaultLimit;
      }
    } catch (e) {
      //handle error
      if (kDebugMode) {
        print('Error fetching articles: $e'); 
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshArticles() async {
    await fetchArticles(isRefresh: true);
  }

  void applySort(SortOrder order) {
    sortOrder = order;
    _sortArticles();
    notifyListeners();
  }

  void _sortArticles() {
    if (sortOrder == SortOrder.newestFirst) {
      articles.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
    } else {
      articles.sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!));
    }
  }
}

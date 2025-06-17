import 'package:flutter/foundation.dart';
import '../../services/api_service/news_api_service.dart';
import '../../model/article.dart';
import '../../utilities/app_constants.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsService _service = NewsService();
  final List<Article> articles = [];
  int currentPageOffset = AppConstants.defaultOffset;
  bool isLoading = false;
  bool hasMore = true;


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
      final newArticles = await _service.getArticles(currentPageOffset, AppConstants.defaultLimit);

      if (newArticles.isEmpty) {
        hasMore = false;
      } else {
        articles.addAll(newArticles);
        currentPageOffset+=AppConstants.defaultLimit;
      }
    } catch (e) {
      // Optionally handle error
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshArticles() async {
     await fetchArticles(isRefresh: true);
  }
}

import '../../services/api_service/news_api_service.dart';
import '../../model/article.dart';

class SearchViewModel {
  final NewsService _service = NewsService();
  final List<Article> articles = []; 
 
 Future<List<Article>> searchArticles(String query) async {
    return await _service.searchArticles(query);
  }
}
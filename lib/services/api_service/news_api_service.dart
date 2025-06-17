import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/article.dart';

class NewsService {
  static const _baseUrl = 'https://api.spaceflightnewsapi.net/v4/articles';

  Future<List<Article>> getArticles(int offset, int limit) async {
    return _fetchArticles({
      'offset': '$offset',
      'limit': '$limit',
    });
  }

  Future<List<Article>> searchArticles(String query) async {
    if (query.isEmpty) return [];
    return _fetchArticles({
      'title_contains': query,
    });
  }

  Future<List<Article>> _fetchArticles(Map<String, String> queryParams) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      return results.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles. Status code: ${response.statusCode}');
    }
  }
}

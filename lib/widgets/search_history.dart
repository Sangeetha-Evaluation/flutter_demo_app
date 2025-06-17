import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory {
  static const _key = 'recent_searches';

  static Future<List<String>> getSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> addSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = List<String>.from(prefs.getStringList(_key) ?? []);

    // Remove if already exists, then add to front
    searches.remove(query);
    searches.insert(0, query);

    // Keep only last 5
    if (searches.length > 5) {
      searches = searches.sublist(0, 5);
    }

    await prefs.setStringList(_key, searches);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

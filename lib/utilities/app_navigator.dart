import 'package:flutter/material.dart';
import '../screens/view/news_detail_screen.dart';
import '../screens/view/news_search_screen.dart';
import '../model/article.dart';

class AppNavigator {
  static void navigateToDetailScreen(BuildContext  context, Article article) {
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsDetailScreen(article: article)
        ),
      );
  }

  static void navigateToSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
       builder: (_) => const SearchScreen(),
    ));
  }

  static void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }
}
  
  
import 'package:flutter/material.dart';
import '../../model/article.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/app_navigator.dart';  
import '../../extensions/date_formatter_extension.dart';

class NewsGridView extends StatelessWidget {
  final List<Article> articles;

  const NewsGridView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: articles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.elementSpacing,
        mainAxisSpacing: AppConstants.elementSpacing,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final article = articles[index];
        return GestureDetector(
          onTap: () => AppNavigator.navigateToDetailScreen(context, article),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.imageUrl != null)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(article.imageUrl!, fit: BoxFit.cover),
                  ),
                Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding / 2),
                  child: Text(
                    article.title ?? '',
                    maxLines: AppConstants.titleMaxLines,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding / 2),
                  child: Text(
                    article.publishedAt?.formatToDate() ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
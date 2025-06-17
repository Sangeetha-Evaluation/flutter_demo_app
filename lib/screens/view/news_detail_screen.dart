import 'package:flutter/material.dart';
import '/model/article.dart';
import '../../extensions/date_formatter_extension.dart';
import '../../utilities/app_strings.dart';
import '../../utilities/app_constants.dart';
import '../../widgets/url_launch_utility.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppConstants.toolbarHeight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null)
            Center(
              child: Image.network(article.imageUrl!, height: AppConstants.imageHeight, fit: BoxFit.cover),
            ),
            const SizedBox(height: AppConstants.elementSpacing),
            Text(
              article.title ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.elementMinSpacing),
            Text(
              article.publishedAt?.formatToDate() ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: AppConstants.elementMinSpacing),
            Text(article.summary ?? '', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton(
              onPressed: () => launchURL(context, article.url ?? ''),
              child: const Text(AppStrings.readFullArticle),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
          ],
        ),
      ),
      );
    }
  }

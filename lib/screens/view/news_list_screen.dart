import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../extensions/date_formatter_extension.dart';
import '../../view_model/news_view_model.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/app_navigator.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>  {
   final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<NewsViewModel>(context, listen: false);
    viewModel.fetchArticles();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !viewModel.isLoading &&
          viewModel.hasMore) {
        viewModel.fetchArticles();
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Consumer<NewsViewModel> (
        builder: (context, viewModel, child) {
          final articles = viewModel.articles;
          if (articles.isEmpty && viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return RefreshIndicator(
            onRefresh: viewModel.refreshArticles,
            child: ListView.builder(
             controller: _scrollController,
             itemCount: articles.length + (viewModel.hasMore ? 1 : 0),
             itemBuilder: (context, index) {
              if (index >= articles.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

              final article = articles[index];
              return ListTile(
                leading: Image.network(
                  article.imageUrl ?? '',
                  width: AppConstants.toolbarHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image),
                ),
                title: Text(article.title ?? ''),
                subtitle: Text(article.publishedAt?.formatToDate() ?? ''),
                onTap: () => AppNavigator.navigateToDetailScreen(context, article
                ),
              );
            },
          ),
          );
        },
      ),
    );
  }
}
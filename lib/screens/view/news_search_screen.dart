import 'dart:async';
import 'package:flutter/material.dart';
import '../../model/article.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/app_strings.dart';
import '../../view_model/news_view_model.dart';
import '../../widgets/news_grid_view.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_search_text_field.dart';
import '../../widgets/search_history.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Article>? _results;
  List<String> _recentSearches = [];
  bool _showRecent = true; // Flag to control recent searches visibility
  bool _loading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    // Automatically focus on the search field after a frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _controller.text.trim();

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 700), () {
      if (query.isNotEmpty) {
        _search(query);
      } else {
        setState(() => _results = null);
        _showRecent = true; // Show recent searches when query is empty
      }
    });
  }

  void _search(String query) async {
    setState(() {
      _loading = true;
    });
    _results = await NewsViewModel().searchArticles(query);
    setState(() {
      _loading = false;
      _showRecent = false;
    });
    await SearchHistory.addSearch(query);
    _loadRecentSearches();

    _results = await NewsViewModel().searchArticles(query);
    setState(() {
      _loading = false;
    });
  }

  void _loadRecentSearches() async {
    final searches = await SearchHistory.getSearches();
    setState(() {
      _recentSearches = searches;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            CustomSearchTextField(
              controller: _controller,
              focusNode: _focusNode,
            ),
            if (_showRecent && _recentSearches.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppConstants.elementSpacing),
                  Text(
                    AppStrings.recentSearches,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _recentSearches.map((item) {
                      return ActionChip(
                        label: Text(item),
                        onPressed: () {
                          _controller.text = item;
                          _search(item);
                        },
                      );
                    }).toList(),
                  ),
                  const Divider(height: 32),
                ],
              ),

            const SizedBox(height: AppConstants.elementSpacing),
            if (_loading)
              Expanded(child: CustomLoaderInGridView.customLoaderInGridView())
            else if (_results != null &&
                _results!.isEmpty &&
                _controller.text.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Text(AppStrings.noResultsFound),
              )
            else if (_results != null)
              Expanded(child: NewsGridView(articles: _results!)),
          ],
        ),
      ),
    );
  }
}

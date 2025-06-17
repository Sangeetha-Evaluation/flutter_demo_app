import 'package:flutter/material.dart';
import 'package:news/screens/view/news_list_screen.dart';
import 'package:news/screens/view/news_search_screen.dart';
import 'package:news/utilities/app_strings.dart'; 


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final GlobalKey<NewsListScreenState> _newsListKey = GlobalKey<NewsListScreenState>();

   late final List<Widget> _screens = [
    NewsListScreen(key: _newsListKey),
    const SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.article),
      label: AppStrings.newsListTitle, 
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: AppStrings.searchNews,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? AppStrings.newsListTitle : AppStrings.searchNews,
        ),
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _newsListKey.currentState?.showSortOptions();
                  },
                ),
              ]
            : null,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

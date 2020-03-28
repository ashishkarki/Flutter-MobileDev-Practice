import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';

class TabScreenWidget extends StatefulWidget {
  @override
  _TabScreenWidgetState createState() => _TabScreenWidgetState();
}

class _TabScreenWidgetState extends State<TabScreenWidget> {
  final List<Map<String, Object>> _pages = [
    {
      'page': CategoriesScreenWidget(),
      'title': 'Categories',
    },
    {
      'page': FavoritesScreenWidget(),
      'title': 'Favorites',
    },
  ];

  int _selectedTabIndex = 0;

  void _selectPage(int tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedTabIndex]['title']),
      ),
      body: _pages[_selectedTabIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: themeCtx.primaryColor,
        unselectedItemColor: Colors.red,
        selectedItemColor: themeCtx.accentColor,
        currentIndex: _selectedTabIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: themeCtx.primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: themeCtx.primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          )
        ],
      ),
    );
  }
}

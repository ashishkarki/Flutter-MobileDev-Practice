import 'package:flutter/material.dart';

import '../interfaces/route-rules-interface.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabScreenWidget extends StatefulWidget implements RouteRulesInterface {
  List<Meal> _favoriteMeals;

  TabScreenWidget();
  TabScreenWidget.withFavorites(this._favoriteMeals);

  @override
  String get routeName => '/'; // this is the root '/'

  @override
  _TabScreenWidgetState createState() => _TabScreenWidgetState();
}

class _TabScreenWidgetState extends State<TabScreenWidget> {
  List<Map<String, Object>> _pages;

  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _pages = [
      {
        'page': CategoriesScreenWidget(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreenWidget(widget._favoriteMeals),
        'title': 'Favorites',
      },
    ];
  }

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
      drawer: MainDrawerWidget(),
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

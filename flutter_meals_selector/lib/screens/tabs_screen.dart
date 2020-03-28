import 'package:flutter/material.dart';

import '../screens/categories_screen.dart';
import 'favorites_screen.dart';

class TabScreenWidget extends StatefulWidget {
  @override
  _TabScreenWidgetState createState() => _TabScreenWidgetState();
}

class _TabScreenWidgetState extends State<TabScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0, // which tab to select initially
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            labelColor: Colors.pink,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
            ),
            indicator: BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.rectangle,
            ),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreenWidget(),
            FavoritesScreenWidget(),
          ],
        ),
      ),
    );
  }
}

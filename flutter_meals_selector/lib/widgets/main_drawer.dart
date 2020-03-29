import 'package:flutter/material.dart';
import 'package:flutter_meals_selector/screens/filters_screen.dart';
import 'package:flutter_meals_selector/screens/tabs_screen.dart';

import '../data/constants.dart';

class MainDrawerWidget extends StatelessWidget {
  Widget buildListTileForDrawer(
      String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);
    final navCtx = Navigator.of(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment:
                Alignment.centerLeft, //vertically - center, horizontally - left
            color: themeCtx.accentColor,
            child: Text(
              APP_NAME_STRING,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: themeCtx.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTileForDrawer('Meals', Icons.restaurant, () {
            navCtx.pushReplacementNamed(const TabScreenWidget().routeName);
          }),
          buildListTileForDrawer('Filters', Icons.settings, () {
            navCtx.pushReplacementNamed(FiltersScreenWidget().routeName);
          }),
        ],
      ),
    );
  }
}

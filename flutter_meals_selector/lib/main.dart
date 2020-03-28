import 'package:flutter/material.dart';

import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './data/constants.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME_STRING,
      theme: mainAppThemeObject,
      // home: CategoriesScreenWidget(),
      initialRoute: '/', //can ignore since '/' is default initial route
      routes: {
        '/': (ctx) => TabScreenWidget(),
        CategoryMealsScreenWidget().routeName: (ctx) =>
            CategoryMealsScreenWidget(),
        MealDetailScreenWidget().routeName: (ctx) => MealDetailScreenWidget(),
      },
      // onGenerateRoute: (settings) { // for routes generated on-the-fly
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreenWidget());
      // },
      onUnknownRoute: (settings) {
        // if every other route fails
        return MaterialPageRoute(builder: (ctx) => CategoriesScreenWidget());
      },
    );
  }
}

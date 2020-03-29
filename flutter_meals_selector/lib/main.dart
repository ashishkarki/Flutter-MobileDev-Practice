import 'package:flutter/material.dart';

import './data/dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './data/constants.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bit hacky - store states elsewhere
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] && !meal.isVegan) {
          return false;
        } else if (_filters['vegeterian'] && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME_STRING,
      theme: mainAppThemeObject,
      // home: CategoriesScreenWidget(),
      initialRoute: '/', //can ignore since '/' is default initial route
      routes: {
        const TabScreenWidget().routeName: (ctx) => const TabScreenWidget(),
        const CategoriesScreenWidget().routeName: (ctx) =>
            const CategoriesScreenWidget(),
        CategoryMealsScreenWidget().routeName: (ctx) =>
            CategoryMealsScreenWidget.withMeals(_availableMeals),
        const MealDetailScreenWidget().routeName: (ctx) =>
            const MealDetailScreenWidget(),
        FiltersScreenWidget().routeName: (ctx) =>
            FiltersScreenWidget.withFilters(
                currentFilters: _filters, setFilters: _setFilters),
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

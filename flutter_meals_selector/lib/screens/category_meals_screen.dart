import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../interfaces/route-rules-interface.dart';

class CategoryMealsScreenWidget extends StatefulWidget
    implements RouteRulesInterface {
  List<Meal> _availableMeals;

  CategoryMealsScreenWidget();

  CategoryMealsScreenWidget.withMeals(this._availableMeals);

  @override
  String get routeName => '/categories-meals';

  @override
  _CategoryMealsScreenWidgetState createState() =>
      _CategoryMealsScreenWidgetState();
}

class _CategoryMealsScreenWidgetState extends State<CategoryMealsScreenWidget> {
  String categoryTitle;
  List<Meal> mealsWithinCategories;
  ModalRoute<Object> modalRte;
  var _loadedInitData =
      false; // bit of hack to prevent didChangeDependencies to reload all the meals over again

  @override
  void initState() {
    // runs into issues when ModalRoute.of.. is used/tapped into
    // so the solution is to use didChangeDependencies which is also called
    // when the state is first initialized by initState()
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadedInitData) {
      modalRte = ModalRoute.of(context);
      final routeArgs = modalRte.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryIdofCurrentMeals = routeArgs['id'];
      mealsWithinCategories = widget._availableMeals.where((meal) {
        return meal.categoryIds.contains(categoryIdofCurrentMeals);
      }).toList();

      _loadedInitData = true;
    }
  }

  void _removeMeals(String mealIdToRemove) {
    setState(() {
      mealsWithinCategories
          .removeWhere((meal) => meal.mealId == mealIdToRemove);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final modalRte = ModalRoute.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItemWidget(
            mealId: mealsWithinCategories[index].mealId,
            title: mealsWithinCategories[index].title,
            imageUrl: mealsWithinCategories[index].imageUrl,
            duration: mealsWithinCategories[index].duration,
            affordability: mealsWithinCategories[index].affordability,
            complexity: mealsWithinCategories[index].complexity,
            removeItemFromMealList: _removeMeals,
          );
        },
        itemCount: mealsWithinCategories.length,
      ),
    );
  }
}

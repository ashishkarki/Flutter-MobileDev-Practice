import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../interfaces/route-rules-interface.dart';

class CategoryMealsScreenWidget extends StatelessWidget
    implements RouteRulesInterface {
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreenWidget(this.categoryId, this.categoryTitle);

  @override
  String get routeName => '/categories-meals';

  @override
  Widget build(BuildContext context) {
    final modalRte = ModalRoute.of(context);
    final routeArgs = modalRte.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryIdofCurrentMeals = routeArgs['id'];
    final mealsWithinCategories = DUMMY_MEALS.where((meal) {
      return meal.categoryIds.contains(categoryIdofCurrentMeals);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Text(mealsWithinCategories[index].title);
        },
        itemCount: mealsWithinCategories.length,
      ),
    );
  }
}

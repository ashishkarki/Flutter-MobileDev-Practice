import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreenWidget extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  FavoritesScreenWidget(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty) {
      return Center(
        child: Text('No favorites Selected Yet!!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItemWidget(
            mealId: _favoriteMeals[index].mealId,
            title: _favoriteMeals[index].title,
            imageUrl: _favoriteMeals[index].imageUrl,
            duration: _favoriteMeals[index].duration,
            affordability: _favoriteMeals[index].affordability,
            complexity: _favoriteMeals[index].complexity,
          );
        },
        itemCount: _favoriteMeals.length,
      );
    }
  }
}

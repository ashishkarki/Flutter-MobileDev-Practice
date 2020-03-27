import 'package:flutter/foundation.dart';

enum Meal_Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Meal_Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String mealId;
  final List<String> categoryIds; // catogories to which this meal belongs
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps; // steps to create this meal
  final int duration; // to prepare the meal
  final Meal_Complexity complexity;
  final Meal_Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    @required this.mealId,
    @required this.categoryIds,
    @required this.title,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
  });
}

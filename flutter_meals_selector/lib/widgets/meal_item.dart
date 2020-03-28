import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../data/constants.dart';

class MealItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int duration;
  final Meal_Complexity complexity;
  final Meal_Affordability affordability;

  MealItemWidget({
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
  });

  void showMealDetails() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showMealDetails,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CATEGORY_ITEM_BORDER_RADIUS),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(CATEGORY_ITEM_BORDER_RADIUS),
                    topRight: Radius.circular(CATEGORY_ITEM_BORDER_RADIUS),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit
                        .cover, // this will resize and crop the image so it fits nicely into its container
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

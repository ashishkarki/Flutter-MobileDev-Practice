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

  Row imageCaptionExpression(String infoToDisplay, IconData iconToDisplay) {
    return Row(
      children: <Widget>[
        Icon(
          iconToDisplay,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          '$infoToDisplay',
        ),
      ],
    );
  }

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
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(CATEGORY_ITEM_BORDER_RADIUS),
                    topRight:
                        const Radius.circular(CATEGORY_ITEM_BORDER_RADIUS),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit
                        .cover, // this will resize and crop the image so it fits nicely into its container
                  ),
                ),
                Positioned(
                  // only works within Stack widget
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    //color: Colors.black54, // black with 54% opacity
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      border: Border.all(
                        width: 2,
                        color: Colors.orange[200],
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(
                        CATEGORY_ITEM_BORDER_RADIUS / 2,
                      ),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: MEAL_NAME_FONT_SIZE,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  imageCaptionExpression(
                      duration.toString() + ' min', Icons.schedule),
                  imageCaptionExpression(
                      getComplexityText(complexity), Icons.work),
                  imageCaptionExpression(
                      getAffordabilityText(affordability), Icons.attach_money),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

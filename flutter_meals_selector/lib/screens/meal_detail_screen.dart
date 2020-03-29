import 'package:flutter/material.dart';
import 'package:flutter_meals_selector/data/dummy_data.dart';
import 'package:flutter_meals_selector/interfaces/route-rules-interface.dart';

class MealDetailScreenWidget extends StatelessWidget
    implements RouteRulesInterface {
  Function _toggleFavorite;
  Function _isMealFavorite;

  MealDetailScreenWidget();

  MealDetailScreenWidget.withToggle(this._toggleFavorite, this._isMealFavorite);

  @override
  String get routeName => 'meal-detail';

  static const meal_detail_image_height = 300.0;
  static const meal_detail_ingredient_margin = 10.0;
  static const meal_detail_ingredient_height = 50.0;

  Widget buildSectionTitle(String text, ThemeData themeCtx) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: meal_detail_ingredient_margin,
      ),
      height: meal_detail_ingredient_height,
      child: Text(
        text,
        style: themeCtx.textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget containerChild) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: containerChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);
    // final mediaQryCtx = MediaQuery.of(context);
    final modelRte = ModalRoute.of(context);
    final navCtx = Navigator.of(context);

    final selectedMealId = (modelRte.settings.arguments as Map)['mealId'];
    final selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.mealId == selectedMealId);

    final mealAppBar = AppBar(
      title: Text('${selectedMeal.title}'),
    );

    return Scaffold(
      appBar: mealAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: meal_detail_image_height,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients', themeCtx),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: themeCtx.primaryColorDark,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedMeal.ingredients[index])),
                ),
              ),
            ),
            buildSectionTitle('Steps', themeCtx),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _toggleFavorite(selectedMealId),
        child: Icon(
          _isMealFavorite(selectedMealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}

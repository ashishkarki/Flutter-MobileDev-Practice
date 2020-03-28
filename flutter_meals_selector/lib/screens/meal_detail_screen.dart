import 'package:flutter/material.dart';
import 'package:flutter_meals_selector/interfaces/route-rules-interface.dart';

class MealDetailScreenWidget extends StatelessWidget
    implements RouteRulesInterface {
  @override
  String get routeName => 'meal-detail';

  @override
  Widget build(BuildContext context) {
    final modelRte = ModalRoute.of(context);

    final mealId = (modelRte.settings.arguments as Map)['mealId'];
    return Scaffold(
      appBar: AppBar(
        title: Text('$mealId'),
      ),
      body: Container(
        child: Text('this is meal details: $mealId'),
        color: Colors.teal,
      ),
    );
  }
}

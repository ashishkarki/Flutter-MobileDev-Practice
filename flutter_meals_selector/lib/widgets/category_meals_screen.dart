import 'package:flutter/material.dart';

import '../widgets/route-rules-interface.dart';

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
    final categoryId = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text('List of recipes in this category'),
      ),
    );
  }
}

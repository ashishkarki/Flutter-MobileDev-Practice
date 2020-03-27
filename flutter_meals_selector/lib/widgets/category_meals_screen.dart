import 'package:flutter/material.dart';

class CategoryMealsScreenWidget extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreenWidget(this.categoryId, this.categoryTitle);

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

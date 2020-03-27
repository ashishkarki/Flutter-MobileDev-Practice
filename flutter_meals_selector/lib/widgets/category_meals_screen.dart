import 'package:flutter/material.dart';

class CategoryMealsScreenWidget extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  CategoryMealsScreenWidget(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
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

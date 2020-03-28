import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../widgets/category_item.dart';

import '../data/dummy_data.dart';

class CategoriesScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME_STRING),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map(
              (category) => CategoryItemWidget(
                category.id,
                category.title,
                category.color,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing:
              20, // decides how much space between our rows and columns
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}

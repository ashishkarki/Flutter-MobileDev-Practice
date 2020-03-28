import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

import '../data/constants.dart';

class CategoryItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItemWidget(this.id, this.title, this.color);

  void selectCategory(BuildContext buildContext) {
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(
    //     builder: (_) => CategoryMealsScreenWidget(id, title),
    //   ),
    // );
    Navigator.of(buildContext).pushNamed(
      CategoryMealsScreenWidget().routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);

    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: themeCtx.primaryColor,
      borderRadius: BorderRadius.circular(CATEGORY_ITEM_BORDER_RADIUS),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: themeCtx.textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.6),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(CATEGORY_ITEM_BORDER_RADIUS),
        ),
      ),
    );
  }
}

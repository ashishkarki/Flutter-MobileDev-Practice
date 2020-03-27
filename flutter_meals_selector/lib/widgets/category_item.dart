import 'package:flutter/material.dart';
import 'package:flutter_meals_selector/constants.dart';
import 'package:flutter_meals_selector/widgets/category_meals_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  final String title;
  final Color color;

  CategoryItemWidget(this.title, this.color);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => CategoryMealsScreenWidget(),
      ),
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

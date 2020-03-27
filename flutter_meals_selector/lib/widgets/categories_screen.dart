import 'package:flutter/material.dart';

class CategoriesScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      children: <Widget>[],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing:
            20, // decides how much space between our rows and columns
        mainAxisSpacing: 20,
      ),
    );
  }
}

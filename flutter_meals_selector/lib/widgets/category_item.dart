import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final String title;
  final Color color;

  CategoryItemWidget(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);

    return Container(
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
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}

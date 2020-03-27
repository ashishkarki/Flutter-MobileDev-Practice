import 'package:flutter/material.dart';

import './widgets/categories_screen.dart';
import './constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME_STRING,
      theme: mainAppThemeObject,
      home: CategoriesScreenWidget(),
    );
  }
}

// only has constants
import 'package:flutter/material.dart';

const APP_NAME_STRING = 'Deli Meals Selector';

const CATEGORY_ITEM_BORDER_RADIUS = 25.0;

final mainAppTextThemeObject = //Theme.of(context).textTheme.copyWith(
    ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: const Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle(
            color: const Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'Baloo2',
            fontWeight: FontWeight.bold,
          ),
        );

final mainAppThemeObject = ThemeData(
  primarySwatch: Colors.orange,
  accentColor: Colors.amber,
  canvasColor: const Color.fromRGBO(255, 254, 229, 1),
  fontFamily: 'Raleway',
  textTheme: mainAppTextThemeObject,
);

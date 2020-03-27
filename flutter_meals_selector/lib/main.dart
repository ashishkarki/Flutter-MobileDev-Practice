import 'package:flutter/material.dart';

import './constants.dart';
import './widgets/home-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME_STRING,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageWidget(),
    );
  }
}

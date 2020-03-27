import 'package:flutter/material.dart';
import 'package:flutter_meals_selector/constants.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME_STRING),
      ),
      body: Center(
        child: Text('Some Navigation items!'),
      ),
    );
  }
}

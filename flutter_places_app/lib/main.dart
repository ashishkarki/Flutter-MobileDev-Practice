import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants.dart';
import './providers/great_places_provider.dart';
import './screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaceProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.tealAccent,
        ),
        home: PlacesListScreen(),
        routes: getRouteTable(context),
      ),
    );
  }
}

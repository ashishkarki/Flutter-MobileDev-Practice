import 'package:flutter/material.dart';

import './screens/add_place_screen.dart';

Map<String, Widget Function(BuildContext)> getRouteTable(BuildContext context,
    {Object miscParams}) {
  final routes = {
    AddPlaceScreen.routeName: (BuildContext context) => AddPlaceScreen(),
  };

  return routes;
}

import 'package:flutter/material.dart';

import './screens/add_place_screen.dart';

Map<String, Widget Function(BuildContext)> getRouteTable(BuildContext context,
    {Object miscParams}) {
  final routes = {
    AddPlaceScreen.routeName: (BuildContext context) => AddPlaceScreen(),
  };

  return routes;
}

void showMyAlert(BuildContext ctx, String message) {
  showDialog(
    context: ctx,
    builder: (ctx) => AlertDialog(
      title: Text('Alert: some issue or error'),
      content: Text(message),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text('Click to Close'),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

import './screens/add_place_screen.dart';
import './config/configuration.dart' as config;

const API_KEY_FOR_GOOGLE_MAPS = config.API_KEY_FOR_GOOGLE_MAPS;

enum COLUMN_NAME_HEADER {
  ID,
  TITLE,
  IMGPATH,
}
const PLACES_DB_NAME_STRING = 'places.db';
const PLACES_TABLE_NAME_STRING = 'user_places';
const Map<COLUMN_NAME_HEADER, String> PLACES_TABLE_COLUMN_NAMES = {
  COLUMN_NAME_HEADER.ID: 'id',
  COLUMN_NAME_HEADER.TITLE: 'title',
  COLUMN_NAME_HEADER.IMGPATH: 'imagePath',
};

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

import 'dart:io';

import 'package:flutter/foundation.dart';
import '../constants.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String newTitle, File newImage) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: newTitle,
      location: null,
      image: newImage,
    );

    _items.add(newPlace);

    notifyListeners();

    // save newPlace into the permanent device storage using Sqlflite
    await DBHelper.insert(
      PLACES_TABLE_NAME_STRING,
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path, // save the path, not the image
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(PLACES_TABLE_NAME_STRING);
    print('fetchAndSetPlaces: $dataList');
    _items = dataList
        .map<Place>(
          (placeItem) => Place(
            id: placeItem['id'],
            title: placeItem['title'],
            location: null, //placeItem['location'],
            image:
                File(placeItem['image']), // create new image File based on path
          ),
        )
        .toList();

    notifyListeners();
  }
}

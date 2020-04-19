import 'dart:io';

import 'package:flutter/foundation.dart';
import '../constants.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String newTitle,
    File newImage,
    PlaceLocation userSelectedLoc,
  ) async {
    final humanReadableAddress = await LocationHelper.getPlaceAddress(
      userSelectedLoc.latitude,
      userSelectedLoc.longitude,
    );
    final newLocation = PlaceLocation(
      latitude: userSelectedLoc.latitude,
      longitude: userSelectedLoc.longitude,
      address: humanReadableAddress,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: newTitle,
      location: newLocation,
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
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(PLACES_TABLE_NAME_STRING);

    _items = dataList
        .map<Place>(
          (placeItem) => Place(
            id: placeItem['id'],
            title: placeItem['title'],
            location: PlaceLocation(
              latitude: placeItem['loc_lat'],
              longitude: placeItem['loc_lng'],
              address: placeItem['address'],
            ),
            image:
                File(placeItem['image']), // create new image File based on path
          ),
        )
        .toList();

    notifyListeners();
  }
}

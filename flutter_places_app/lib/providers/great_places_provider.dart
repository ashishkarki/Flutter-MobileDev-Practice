import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  addPlace(String newTitle, File newImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: newTitle,
      location: null,
      image: newImage,
    );

    _items.add(newPlace);

    notifyListeners();
  }
}

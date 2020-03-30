import 'package:flutter/material.dart';

import '../constants.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((product) => product.isFavorite).toList();
    // }

    return [..._items]; //copy of items
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String idToFind) {
    return _items.firstWhere((product) => product.id == idToFind);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    notifyListeners();
  }
}

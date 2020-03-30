import 'package:flutter/material.dart';

import '../constants.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items]; //copy of items
  }

  Product findById(String idToFind) {
    return _items.firstWhere((product) => product.id == idToFind);
  }

  void addProduct() {
    notifyListeners();
  }
}

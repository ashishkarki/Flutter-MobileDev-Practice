import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items]; //copy of items
  }
}

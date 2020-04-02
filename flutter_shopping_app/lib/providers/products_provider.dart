import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = dummyProducts;

  // var _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items]; //copy of items
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String idToFind) {
    return _items.firstWhere((product) => product.id == idToFind);
  }

  Future<void> addProduct(Product product) {
    const postUrl = FIREBASE_WEB_SERVER_URL + '/products.json';

    return http
        .post(
      postUrl,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    )
        .then((response) {
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.insert(0, newProduct);

      notifyListeners();
    });
  }

  void updateProduct(String productIdToBeUpdated, Product updatedProduct) {
    final toBeUpdatedProductIndex =
        _items.indexWhere((product) => product.id == productIdToBeUpdated);

    if (toBeUpdatedProductIndex >= 0) {
      // yes, the product exists
      _items[toBeUpdatedProductIndex] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String idToBeDeleted) {
    _items.removeWhere((product) => product.id == idToBeDeleted);

    notifyListeners();
  }
}

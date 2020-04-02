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

  Future<dynamic> addProduct(Product product) async {
    const postUrl = FIREBASE_WEB_SERVER_URL + '/products';

    try {
      final response = await http.post(
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
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.insert(0, newProduct);

      notifyListeners();
    } catch (error) {
      print('Error during addProduct: ${error.toString()}');
      throw error;
    }
    //   .then(
    // (response) {

    // to stay same with catchError throwing Future<dynamic>
    // return Future.value();
    //   },
    // ).catchError((error) {
    //   print('Error during addProduct: ${error.toString()}');
    //   throw error;
    // });
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

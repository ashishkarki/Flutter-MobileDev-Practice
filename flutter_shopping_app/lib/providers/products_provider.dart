import 'package:flutter/material.dart';

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

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    _items.insert(0, newProduct);

    notifyListeners();
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

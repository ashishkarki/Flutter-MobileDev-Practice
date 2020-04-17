import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../interfaces/common-interfaces.dart';
import '../constants.dart';
import './product.dart';
import '../models/http_exception.dart';

class ProductsProvider extends CommonInterfaces with ChangeNotifier {
  final String authToken;
  final String userId;

  ProductsProvider.empty({this.authToken, this.userId});

  ProductsProvider.withProxy(this.authToken, this.userId, this._items);

  List<Product> _items = [];

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

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final getUrl = FIREBASE_WEB_SERVER_URL +
        FIREBASE_DB_PRODUCTS_SUFFIX +
        '.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(getUrl);
      final jsonBody = json.decode(response.body) as Map<String, dynamic>;
      if (jsonBody == null) {
        return;
      }

      final favoriteUrl = FIREBASE_WEB_SERVER_URL +
          '/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(favoriteUrl);
      final favoriteData = jsonDecode(favoriteResponse.body);

      final List<Product> productsFromFirebaseDB = [];
      jsonBody.forEach((prodId, prodMap) {
        productsFromFirebaseDB.add(
          Product(
            id: prodId,
            title: prodMap['title'],
            description: prodMap['description'],
            price: prodMap['price'],
            imageUrl: prodMap['imageUrl'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        );
      });

      _items = productsFromFirebaseDB;
      notifyListeners();
      printer();
    } on Exception catch (error) {
      throw error;
    }
  }

  Future<dynamic> addProduct(Product product) async {
    final postUrl = FIREBASE_WEB_SERVER_URL +
        FIREBASE_DB_PRODUCTS_SUFFIX +
        '.json?auth=$authToken';

    try {
      final response = await http.post(
        postUrl,
        body: productToJsonEncodedHelper(
          product,
          userId,
          updateFavorite: false,
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

  Future<void> updateProduct(
      String productIdToBeUpdated, Product updatedProduct) async {
    final toBeUpdatedProductIndex =
        _items.indexWhere((product) => product.id == productIdToBeUpdated);

    if (toBeUpdatedProductIndex >= 0) {
      // yes, the product exists
      try {
        final updateUrl = FIREBASE_WEB_SERVER_URL +
            FIREBASE_DB_PRODUCTS_SUFFIX +
            '/$productIdToBeUpdated.json?auth=$authToken';

        await http.patch(
          updateUrl,
          body: productToJsonEncodedHelper(
            updatedProduct,
            userId,
            updateFavorite: false,
          ),
        );

        _items[toBeUpdatedProductIndex] = updatedProduct;
        notifyListeners();
      } catch (exception) {
        throw exception;
      }
    }
  }

  Future<void> deleteProduct(String idToBeDeleted) async {
    // USING OPTIMISTIC UPDATING: remove from memory first and re-stating if needed
    final existingProductIndex =
        _items.indexWhere((product) => product.id == idToBeDeleted);
    // we re-instate this if Firebase deletion was unsuccessful
    var existingProduct = _items[existingProductIndex];
    // now remove the item from list, yet it remains in memory since existingProduct refers to it
    _items.removeAt(existingProductIndex);
    notifyListeners();

    // now send the http delete and see if the request succeds
    final deleteUrl = FIREBASE_WEB_SERVER_URL +
        FIREBASE_DB_PRODUCTS_SUFFIX +
        '/$idToBeDeleted.json?auth=$authToken';
    final response = await http.delete(deleteUrl);
    // means the http delete was successful, de-reference existingProduct
    // http.delete doesn't throw error for error codes (i.e code >= 400),
    // so, we have to throw error manually
    if (response.statusCode >= 400) {
      // error using delete request, re-instate the product using existingProduct
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();

      throw HttpException('Could not delete the product!!');
    }
    // if there is no error, de-reference the deleted, existing product from memory too
    existingProduct = null;
  }

  // helper method to debug
  void printer() {
    _items.forEach((item) {
      print('${item.title}, ${item.description}, ${item.isFavorite} \n');
    });
  }
}

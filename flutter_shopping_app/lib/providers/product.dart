import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/http_exception.dart';
import 'package:http/http.dart' as http;

import '../interfaces/common-interfaces.dart';
import '../constants.dart';

class Product extends CommonInterfaces with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatusHelper() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken) async {
    // USING OPTIMISTIC UPDATING:
    this.toggleFavoriteStatusHelper();

    final updateUrl = FIREBASE_WEB_SERVER_URL +
        FIREBASE_DB_PRODUCTS_SUFFIX +
        '/${this.id}.json?auth=$authToken';
    final response = await http.patch(
      updateUrl,
      body: productToJsonEncodedHelper(this,
          updateOthers: false, updateFavorite: true),
    );

    if (response.statusCode >= 400) {
      toggleFavoriteStatusHelper();

      throw HttpException('Error updating favorite status for this item');
    }
  }
}

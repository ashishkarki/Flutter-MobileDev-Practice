import 'dart:convert';

import '../providers/product.dart';

class CommonInterfaces {
  String productToJsonEncodedHelper(Product product,
      {bool updateOthers = true, bool updateFavorite = false}) {
    Map<String, dynamic> mustPart = {};

    if (updateOthers) {
      mustPart.addAll({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      });
    }

    if (updateFavorite) {
      mustPart.addAll(
        {
          'isFavorite': product.isFavorite,
        },
      );
    }
    return json.encode(
      mustPart,
    );
  }
}

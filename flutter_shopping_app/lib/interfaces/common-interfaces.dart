import 'dart:convert';

import '../providers/cart_provider.dart';
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

  String orderToJsonEncodedHelper(
    List<CartItemObject> cartProducts,
    double total,
    DateTime timestamp,
  ) {
    Map<String, dynamic> mustPart = {
      'amount': total,
      'dateTime': timestamp.toIso8601String(),
      'cartProducts': cartProducts
          .map(
            (cartProd) => {
              'id': cartProd.id,
              'title': cartProd.title,
              'quantity': cartProd.quantity,
              'price': cartProd.price,
            },
          )
          .toList(),
    };

    return json.encode(
      mustPart,
    );
  }
}

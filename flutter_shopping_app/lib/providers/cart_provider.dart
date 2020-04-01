import 'package:flutter/foundation.dart';

class CartItemObject {
  final String id; // different from Id of product
  final String title;
  final int quantity;
  final double price; // pricePerItem

  CartItemObject({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItemObject> _items = {}; // key=productId, value=cartItem

  Map<String, CartItemObject> get items {
    return {..._items};
  }

  int get itemCount {
    if (_items == null) {
      return 0;
    }

    final totalQuantities = _items.entries.map<int>((mapEntry) {
      return mapEntry.value.quantity;
    }).fold<int>(0, (sum, quantity) {
      return sum + quantity;
    });
    // print('totalQuantities::' + totalQuantities.toString());

    return totalQuantities; //_items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_items != null && _items.containsKey(productId)) {
      // item already exits, just increase quantity
      _items.update(
        productId,
        (existingCartItem) => CartItemObject(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItemObject(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItemObject(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity - 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      // if this item has only 1 quantity., remove it from colelction
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

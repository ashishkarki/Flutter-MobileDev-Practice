import 'package:flutter/foundation.dart';

import '../providers/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItemObject> cartProducts;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.cartProducts,
    @required this.dateTime,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [...orders];
  }

  void addOrder(
    List<CartItemObject> cartProducts,
    double total,
  ) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        cartProducts: cartProducts,
      ),
    );

    notifyListeners();
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }
}

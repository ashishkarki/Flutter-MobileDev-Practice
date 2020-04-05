import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../interfaces/common-interfaces.dart';
import 'package:http/http.dart' as http;

import '../providers/cart_provider.dart';
import '../constants.dart';

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

class OrdersProvider extends CommonInterfaces with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(
    List<CartItemObject> cartProducts,
    double total,
  ) async {
    final timestamp = DateTime.now();
    const postUrl =
        FIREBASE_WEB_SERVER_URL + FIREBASE_DB_ORDERS_SUFFIX + '.json';

    try {
      final response = await http.post(
        postUrl,
        body: orderToJsonEncodedHelper(
          cartProducts,
          double.parse(total.toStringAsFixed(2)),
          timestamp,
        ),
      );

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: DateTime.now(),
          cartProducts: cartProducts,
        ),
      );
    } catch (exception) {
      throw exception;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchAndSetOrders() async {
    const getUrl =
        FIREBASE_WEB_SERVER_URL + FIREBASE_DB_ORDERS_SUFFIX + '.json';

    final response = await http.get(getUrl);
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          cartProducts: (orderData['cartProducts'] as List<dynamic>)
              .map(
                (prod) => CartItemObject(
                  id: prod['id'],
                  price: prod['price'],
                  quantity: prod['quantity'],
                  title: prod['title'],
                ),
              )
              .toList(),
        ),
      );
    });

    _orders = loadedOrders;
    print('fetched orders: $_orders');
    notifyListeners();
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }
}

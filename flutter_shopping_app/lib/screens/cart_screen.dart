import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart' show CartProvider;
import '../widgets/cart_item.dart';
import '../providers/orders_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total:',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Spacer(), // takes up all space in between
                  Chip(
                    label: Text(
                      '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: themeData.textTheme.title.color,
                      ),
                    ),
                    backgroundColor: themeData.backgroundColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<OrdersProvider>(
                        context,
                        listen: false,
                      ).addOrder(
                        cartProvider.items.values.toList(),
                        cartProvider.totalAmount,
                      );
                      cartProvider.clear();
                    },
                    child: const Text(
                      'Place Order',
                    ),
                    textColor: themeData.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, itemIdx) {
                final cartItem = cartProvider.items.values.toList()[itemIdx];

                return CartItemWidget(
                  id: cartItem.id,
                  productId: cartProvider.items.keys.toList()[itemIdx],
                  quantity: cartItem.quantity,
                  price: cartItem.price,
                  title: cartItem.title,
                );
              },
              itemCount: cartProvider.items.length,
            ),
          ),
        ],
      ),
    );
  }
}

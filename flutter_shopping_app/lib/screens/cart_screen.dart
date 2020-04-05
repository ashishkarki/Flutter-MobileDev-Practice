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
                  PlaceOrderButtonWidget(
                      cartProvider: cartProvider, themeData: themeData),
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

class PlaceOrderButtonWidget extends StatefulWidget {
  const PlaceOrderButtonWidget({
    Key key,
    @required this.cartProvider,
    @required this.themeData,
  }) : super(key: key);

  final CartProvider cartProvider;
  final ThemeData themeData;

  @override
  _PlaceOrderButtonWidgetState createState() => _PlaceOrderButtonWidgetState();
}

class _PlaceOrderButtonWidgetState extends State<PlaceOrderButtonWidget> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : FlatButton(
            onPressed: (widget.cartProvider.totalAmount <= 0 || _isLoading)
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<OrdersProvider>(
                      context,
                      listen: false,
                    ).addOrder(
                      widget.cartProvider.items.values.toList(),
                      widget.cartProvider.totalAmount,
                    );

                    setState(() {
                      _isLoading = false;
                    });

                    widget.cartProvider.clear();
                  },
            child: const Text(
              'Place Order',
            ),
            textColor: widget.themeData.primaryColor,
          );
  }
}

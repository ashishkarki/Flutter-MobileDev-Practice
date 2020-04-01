import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders_provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawerWidget(),
      body: ordersProvider.orders.length == 0
          ? Card(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 50,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.orange,
                  width: 3,
                )),
                child: Card(
                  elevation: 3,
                  child: Text(
                    'No orders yet. Please use the Products Screen to order some.',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 30,
                      //backgroundColor: Colors.black45,
                    ),
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, itemIdx) => OrderItemWidget(
                ordersProvider.orders[itemIdx],
              ),
              itemCount: ordersProvider.orders.length,
            ),
    );
  }
}

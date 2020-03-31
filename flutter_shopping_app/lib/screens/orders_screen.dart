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
              child: Text('No orders yet..'),
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

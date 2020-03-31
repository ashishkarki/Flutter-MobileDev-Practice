import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;

  OrderItemWidget(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${orderItem.amount}'),
            subtitle: Text(
              DateFormat('MM dd yyyy hh:mm').format(orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

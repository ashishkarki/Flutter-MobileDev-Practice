import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItem;

  OrderItemWidget(this.orderItem);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isExpanded
          ? min(
              (widget.orderItem.cartProducts.length * 20.0 + 150.0),
              250.0,
            )
          : 100,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.orderItem.amount}'),
              subtitle: Text(
                DateFormat('MM dd yyyy hh:mm')
                    .format(widget.orderItem.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            //if (_isExpanded)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              height: _isExpanded
                  ? min(
                      (widget.orderItem.cartProducts.length * 20.0 + 50.0),
                      150.0,
                    )
                  : 0.0,
              decoration: BoxDecoration(
                border: _isExpanded
                    ? Border.all(
                        color: Colors.black45,
                        width: 2,
                      )
                    : null,
              ),
              child: ListView(
                children: widget.orderItem.cartProducts
                    .map(
                      (product) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            product.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.quantity} x \$${product.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

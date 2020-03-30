import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String productTitle =
        (ModalRoute.of(context).settings.arguments as Map)['productTitle'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productTitle,
        ),
      ),
    );
  }
}

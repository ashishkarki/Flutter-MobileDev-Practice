import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productTitle;

  const ProductDetailScreen(this.productTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productTitle,
        ),
      ),
    );
  }
}

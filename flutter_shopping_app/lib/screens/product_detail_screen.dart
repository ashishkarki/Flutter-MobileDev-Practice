import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
      context,
      listen: false, // don't re-run build method when provider's data changes
    );
    final String productId =
        (ModalRoute.of(context).settings.arguments as Map)['productId'];
    final loadedProduct = productsData.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
        ),
      ),
    );
  }
}

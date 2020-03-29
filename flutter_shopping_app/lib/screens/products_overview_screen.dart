import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/widgets/product_item.dart';
import '../constants.dart';

import '../models/product.dart';

class ProductsOverScreen extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME_STRING),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, itemIndex) => ProductItem(
          loadedProducts[itemIndex].id,
          loadedProducts[itemIndex].title,
          loadedProducts[itemIndex].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2, // means height is 3 and width is 2 ratio
          crossAxisSpacing: 10, // spacing betn the columns
          mainAxisSpacing: 10, // spaching betn the rows
        ),
      ),
    );
  }
}

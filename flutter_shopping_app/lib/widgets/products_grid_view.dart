import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class ProductsGridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, itemIndex) => ChangeNotifierProvider(
        create: (ctx) => loadedProducts[itemIndex],
        child: ProductItem(
            // loadedProducts[itemIndex].id,
            // loadedProducts[itemIndex].title,
            // loadedProducts[itemIndex].imageUrl,
            // loadedProducts[itemIndex].price,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2, // means height is 3 and width is 2 ratio
        crossAxisSpacing: 10, // spacing betn the columns
        mainAxisSpacing: 10, // spaching betn the rows
      ),
    );
  }
}

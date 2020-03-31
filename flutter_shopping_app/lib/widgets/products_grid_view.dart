import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class ProductsGridViewWidget extends StatelessWidget {
  final bool _showOnlyFavorites;

  ProductsGridViewWidget(this._showOnlyFavorites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final loadedProducts =
        _showOnlyFavorites ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, itemIndex) => ChangeNotifierProvider.value(
        // .value pattern is the way to go for GridView's
        value: loadedProducts[itemIndex],
        // ChangeNotifierProvider(
        //   create: (ctx) => loadedProducts[itemIndex],
        child: ProductItem(),
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

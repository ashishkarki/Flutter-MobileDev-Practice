import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/products_grid_view.dart';
import '../constants.dart';

class ProductsOverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME_STRING),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorites) {
                productsContainer.showFavoritesOnly();
              } else {
                productsContainer.showAll();
              }
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGridViewWidget(),
    );
  }
}

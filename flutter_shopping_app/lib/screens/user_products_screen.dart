import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static final routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productsProvider = Provider.of<ProductsProvider>(context);
    final navState = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your (user\'s) Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              navState.pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawerWidget(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, AsyncSnapshot snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx, productsProvider, _) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (ctx, itemIdx) {
                            final product = productsProvider.items[itemIdx];
                            return Column(
                              children: [
                                UserProductItem(
                                  product.id,
                                  product.title,
                                  product.imageUrl,
                                ),
                                Divider(),
                              ],
                            );
                          },
                          itemCount: productsProvider.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}

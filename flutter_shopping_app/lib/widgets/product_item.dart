import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import '../constants.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);
    final Product productProvider =
        Provider.of<Product>(context, listen: false);
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.routeName, arguments: {
              'productId': productProvider.id,
            });
          },
          child: FadeInImage(
            placeholder: AssetImage('assets/images/product-placeholder.png'),
            image: NetworkImage(productProvider.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        header: Text(
          '$CURRENCY_SYMBOL${productProvider.price.toStringAsFixed(2)}',
          style: TextStyle(
            color: themeCtx.accentColor,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                (product.isFavorite == null || !product.isFavorite)
                    ? Icons.favorite_border
                    : Icons.favorite,
              ),
              onPressed: () async => await product.toggleFavoriteStatus(
                authProvider.token,
                authProvider.userId,
              ),
              color: themeCtx.accentColor,
            ),
          ),
          title: Text(
            productProvider.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cartProvider.addItem(
                productProvider.id,
                productProvider.title,
                productProvider.price,
              );

              final scaffoldSt = Scaffold.of(context);
              scaffoldSt.hideCurrentSnackBar();
              // to show a info pop-up following: this establishes connection to nearest widget
              // that controls the page we are seeing (in this case the scafold in product_overview_screen)
              scaffoldSt.showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to your cart',
                    // textAlign: TextAlign.center,
                  ),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cartProvider.removeSingleItem(
                          productProvider.id,
                        );
                      }),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            color: themeCtx.accentColor,
          ),
        ),
      ),
    );
  }
}

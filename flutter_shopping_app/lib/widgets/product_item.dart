import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';
import '../constants.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final String productTitle;
  final String productImageUrl;
  final double productPrice;

  const ProductItem(
    this.productId,
    this.productTitle,
    this.productImageUrl,
    this.productPrice,
  );

  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                        productTitle,
                      )),
            );
          },
          child: Image.network(
            this.productImageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: Text(
          '$CURRENCY_SYMBOL${productPrice.toStringAsFixed(2)}',
          style: TextStyle(
            color: themeCtx.accentColor,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
            color: themeCtx.accentColor,
          ),
          title: Text(
            productTitle,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: themeCtx.accentColor,
          ),
        ),
      ),
    );
  }
}

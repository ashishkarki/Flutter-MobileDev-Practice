import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final String productTitle;
  final String productImageUrl;

  const ProductItem(
    this.productId,
    this.productTitle,
    this.productImageUrl,
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
          'some header',
          style: TextStyle(
            color: Colors.lime,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(
      context,
      listen: false, // don't re-run build method when provider's data changes
    );
    final String productId =
        (ModalRoute.of(context).settings.arguments as Map)['productId'];
    final loadedProduct = productsData.findById(productId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     loadedProduct.title,
      //   ),
      // ),
      body: CustomScrollView(
        // CustomScrollView gives more control
        // SingleChildScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300, //from previous height
            pinned: true, //show appbar when out of view
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
                style: TextStyle(
                  color: Colors.white70,
                  backgroundColor: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProduct.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 800, // hack to show scroll effect
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

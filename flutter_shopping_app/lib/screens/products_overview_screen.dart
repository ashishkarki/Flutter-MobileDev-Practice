import 'package:flutter/material.dart';

import '../widgets/products_grid_view.dart';
import '../constants.dart';

class ProductsOverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME_STRING),
      ),
      body: ProductsGridViewWidget(),
    );
  }
}

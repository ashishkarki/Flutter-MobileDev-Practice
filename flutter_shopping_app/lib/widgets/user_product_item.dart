import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final navState = Navigator.of(context);
    final scaffoldState = Scaffold.of(context);

    final productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );

    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 30.0,
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  navState.pushNamed(
                    EditProductScreen.routeName,
                    arguments: {'id': id},
                  );
                },
                color: themeData.primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await productsProvider.deleteProduct(id);
                  } on Exception catch (_) {
                    scaffoldState.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Deletion of this product failed!!!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                color: themeData.errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

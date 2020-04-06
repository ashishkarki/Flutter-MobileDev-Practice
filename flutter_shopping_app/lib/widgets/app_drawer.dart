import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/user_products_screen.dart';

import '../screens/orders_screen.dart';
import '../providers/auth_provider.dart';

class AppDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navCtx = Navigator.of(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Screen Selector'),
            automaticallyImplyLeading: false, // don't show back button
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              navCtx.pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              navCtx.pushReplacementNamed(
                OrdersScreen.routeName,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              navCtx.pushReplacementNamed(
                UserProductScreen.routeName,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              navCtx.pop();
              navCtx.pushReplacementNamed('/'); // RECOMMENDATION
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}

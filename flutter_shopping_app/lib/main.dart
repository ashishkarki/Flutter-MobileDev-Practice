import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/orders_provider.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './constants.dart';
import './providers/products_provider.dart';
import 'providers/cart_provider.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (ctx) => ProductsProvider.empty(),
          update: (ctx, authProvider, previousProdProvider) =>
              ProductsProvider.withProxy(
            authProvider.token,
            previousProdProvider == null ? [] : previousProdProvider.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        // ChangeNotifierProvider.value(
        //   value: OrdersProvider(),
        // ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (ctx) => OrdersProvider.empty(),
          update: (ctx, authProvider, prevOrdersProvider) =>
              OrdersProvider.withProxy(
            authProvider.token,
            prevOrdersProvider == null ? [] : prevOrdersProvider.orders,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) => MaterialApp(
          title: APP_NAME_STRING,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: authProvider.isAuthenticated
              ? ProductsOverviewScreen()
              : AuthScreen(),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}

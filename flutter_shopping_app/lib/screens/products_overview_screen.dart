import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../widgets/products_grid_view.dart';
import '../constants.dart';
import '../widgets/badge.dart';
import '../providers/products_provider.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static final routeName = '/products-overview';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  var _isError = false;

  @override
  void initState() {
    // Provider.of<ProductsProvider>(context)
    //     .fetechAndSetProducts(); // WON'T WORK without listen: false

    // One way to workaround the above issue is: (second way is didChangeDependencies())
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).fetechAndSetProducts();
    // });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        _isError = false;
      });

      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME_STRING),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  // productsContainer.showFavoritesOnly();
                  _showOnlyFavorites = true;
                } else {
                  // productsContainer.showAll();
                  _showOnlyFavorites = false;
                }
              });
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
          Consumer<CartProvider>(
            builder: (ctx, cart, consumerChild) => Badge(
              child: consumerChild,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              // this child is passed  to Consumer as consumerChild argument above
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawerWidget(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _isError
              ? Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Sorry some error occurred. Re-start the app or contact the administrator.',
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.black45,
                    ),
                  ),
                )
              : ProductsGridViewWidget(_showOnlyFavorites),
    );
  }
}

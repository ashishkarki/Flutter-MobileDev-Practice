import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navState = Navigator.of(context);
    final greatPlaceProvider = Provider.of<GreatPlaceProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // 'pushNamed' since we want to go back
              navState.pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: greatPlaceProvider.fetchAndSetPlaces(),
        builder: (ctx, AsyncSnapshot<dynamic> snapShot) => snapShot
                    .connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaceProvider>(
                child: Text(
                  'No places, add some now',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ), // ch below gets this child
                builder: (ctx, greatPlacesProvider, ch) => greatPlacesProvider
                            .items.length <=
                        0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlacesProvider.items.length,
                        itemBuilder: (ctx, itemIdx) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                greatPlacesProvider.items[itemIdx].image),
                          ),
                          title: Text(greatPlacesProvider.items[itemIdx].title),
                          subtitle: Text(greatPlacesProvider
                              .items[itemIdx].location.address),
                          onTap: () {
                            // go to a details page
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}

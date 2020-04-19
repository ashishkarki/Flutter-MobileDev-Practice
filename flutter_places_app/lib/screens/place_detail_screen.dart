import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import '../screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final grtPlacePvd = Provider.of<GreatPlaceProvider>(
      context,
      listen: false,
    );
    final id = ModalRoute.of(context).settings.arguments;
    final placeToShowDetailsFor = grtPlacePvd.findPlaceById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Place details for : ${placeToShowDetailsFor.title}'),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              placeToShowDetailsFor.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            placeToShowDetailsFor.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapScreen(
                    initialLocation: placeToShowDetailsFor.location,
                    isSelecting: false, // optional to send this bool
                  ),
                ),
              );
            },
            child: Text('View on Google Map'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

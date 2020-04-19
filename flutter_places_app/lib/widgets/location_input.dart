import 'package:flutter/material.dart';
import 'package:flutter_places_app/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';

class LocationInputWidget extends StatefulWidget {
  final void Function(double, double) onSelectPlace;

  LocationInputWidget(this.onSelectPlace);

  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewLocationImgUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    final staticMapImgUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );

    setState(() {
      _previewLocationImgUrl = staticMapImgUrl;
    });

    widget.onSelectPlace(locationData.latitude, locationData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }

    // else process the data
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // to preview the map location
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewLocationImgUrl == null
              ? Text(
                  'No location selected',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewLocationImgUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Wrap(
          direction: Axis
              .vertical, // just keeping this, doesn't seem to have any effect
          alignment: WrapAlignment.center,
          // textDirection: TextDirection.ltr,
          spacing: 20.0,
          //runSpacing: 20.0,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(
                Icons.map,
              ),
              label: Text(
                'Select on Map',
              ),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}

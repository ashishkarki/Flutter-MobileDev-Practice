import 'package:flutter/material.dart';
import 'package:flutter_places_app/constants.dart';
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
  BuildContext ourBuildCtx;

  void _loadPreviewMap(double latitude, double longitude) {
    final staticMapImgUrl = LocationHelper.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _previewLocationImgUrl = staticMapImgUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();

      _loadPreviewMap(locationData.latitude, locationData.longitude);

      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (exception) {
      // for example if the user doesn't grant us permission to get lcoation
      showMyAlert(ourBuildCtx, 'Location error:provide access to location');
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(ourBuildCtx).push<LatLng>(
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
    _loadPreviewMap(selectedLocation.latitude, selectedLocation.longitude);

    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    ourBuildCtx = context;

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

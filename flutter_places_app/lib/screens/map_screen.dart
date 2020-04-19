import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting; //

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 27.664400,
      longitude: 85.318794,
    ),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _userSelectedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _userSelectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View Selected'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                icon: Icon(Icons.check),
                onPressed: _userSelectedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_userSelectedLocation);
                      }),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_userSelectedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'), //must be unique
                  position: _userSelectedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}

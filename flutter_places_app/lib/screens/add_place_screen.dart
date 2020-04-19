import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../models/place.dart';
import '../widgets/location_input.dart';
import '../providers/great_places_provider.dart';
import '../constants.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _selectedImage;
  PlaceLocation _userSelectedLocation;

  void _selectPlace(double lat, double lng) {
    _userSelectedLocation = PlaceLocation(
      latitude: lat,
      longitude: lng,
    );
  }

  void _selectImage(File userSelectedImg) {
    _selectedImage = userSelectedImg;
  }

  void _savePlace(
    GreatPlaceProvider greatPlaceProvider,
    NavigatorState navState,
  ) {
    if (_titleController.text.isEmpty ||
        _selectedImage == null ||
        _userSelectedLocation == null) {
      showMyAlert(context, "Please add title and/or select image/location");
      return;
    }

    greatPlaceProvider.addPlace(
        _titleController.text, _selectedImage, _userSelectedLocation);

    // also pop this page
    navState.pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final greatPlaceProvider = Provider.of<GreatPlaceProvider>(
      context,
      listen: false,
    );
    final navState = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween, // not needed because of Expanded below
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    // title
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // image
                    ImageInputWidget(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInputWidget(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: () => _savePlace(
              greatPlaceProvider,
              navState,
            ),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize
                .shrinkWrap, //makes button big without margins
            color: themeData.accentColor,
          ),
        ],
      ),
    );
  }
}

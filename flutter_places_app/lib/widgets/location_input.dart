import 'package:flutter/material.dart';

class LocationInputWidget extends StatefulWidget {
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewLocationImgUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // to preview the map location
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
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
          // direction: Axis.horizontal,
          // alignment: WrapAlignment.start,
          // textDirection: TextDirection.ltr,
          spacing: 40.0,
          //runSpacing: 20.0,
          children: [
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: () {},
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

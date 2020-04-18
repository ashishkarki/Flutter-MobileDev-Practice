import 'dart:io';

import 'package:flutter/material.dart';

class ImageInputWidget extends StatefulWidget {
  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File _storedImage;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQry = MediaQuery.of(context);
    print('mediaQry : ${mediaQry.size.width}, ${mediaQry.size.height}');

    return Row(
      children: <Widget>[
        Container(
          // for image preview
          width: mediaQry.size.width - 200.0, //150,
          height: mediaQry.size.height - 400.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Selected',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          // allows the button to take all  remaining space in this row
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: themeData.primaryColor,
            onPressed: () {},
          ),
        ), //to browse image
      ],
    );
  }
}

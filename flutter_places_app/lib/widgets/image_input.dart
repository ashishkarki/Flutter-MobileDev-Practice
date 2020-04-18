import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInputWidget extends StatefulWidget {
  final Function onSelectImage;

  ImageInputWidget(this.onSelectImage);

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = imageFile;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // get the name of the image from the whole/absolute image path-name
    final fileNameWithExt = path.basename(imageFile.path);

    final savedImage = await imageFile.copy('${appDir.path}/$fileNameWithExt');
    widget.onSelectImage(savedImage); // send the image over to add_place_screen
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQry = MediaQuery.of(context);
    //print('mediaQry : ${mediaQry.size.width}, ${mediaQry.size.height}');

    return Row(
      children: <Widget>[
        Container(
          // for image preview
          width: mediaQry.size.width - 200.0, //150,
          height: mediaQry.size.height -
              (mediaQry.orientation == Orientation.portrait ? 400.0 : 250.0),
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
            onPressed: _takePicture,
          ),
        ), //to browse image
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BodyTextControlWidget extends StatelessWidget {
  final Function rollingTextClickHandler;

  BodyTextControlWidget(this.rollingTextClickHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: rollingTextClickHandler,
        child: Text('Click and see the body text change'),
        textColor: Colors.blue,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

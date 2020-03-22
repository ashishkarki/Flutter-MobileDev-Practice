import 'package:flutter/material.dart';

class BodyTextResetWidget extends StatelessWidget {
  final Function resetTextClickHandler;

  BodyTextResetWidget(this.resetTextClickHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: resetTextClickHandler,
        key: Key('Reset Button'),
        child: Text('Click Here to start again'),
      ),
    );
  }
}

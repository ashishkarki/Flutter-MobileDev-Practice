import 'package:flutter/material.dart';

import './common-values.dart';

class SelectionButton extends StatelessWidget {
  final ResponseButtonType buttonType;
  final Color buttonColor;
  final Function onButtonPressed;

  const SelectionButton({
    this.buttonType = ResponseButtonType.TRUE,
    this.buttonColor = Colors.red,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: buttonColor,
          child: Text(
            responseButtonStringUtil(buttonType),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () => onButtonPressed(buttonType),
        ),
      ),
    );
  }
}

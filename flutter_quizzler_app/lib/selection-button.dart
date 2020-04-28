import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function onButtonPressed;

  const SelectionButton({
    this.buttonText = 'True',
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
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            onButtonPressed();
          },
        ),
      ),
    );
  }
}

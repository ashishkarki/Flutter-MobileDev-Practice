import 'package:flutter/material.dart';

class BodyTextWidget extends StatelessWidget {
  final String rollingBodyText;

  BodyTextWidget(this.rollingBodyText);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      rollingBodyText,
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 30,
        color: Colors.indigo,
      ),
    ));
  }
}

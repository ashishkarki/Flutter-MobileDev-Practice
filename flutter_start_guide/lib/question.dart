import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String questionText;

  QuestionWidget(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20.0),
      color: Color.fromRGBO(200, 100, 100, 0.5),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}

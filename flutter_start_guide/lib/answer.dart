import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final Function answerClickHandler;
  final String answerText;

  AnswerWidget(this.answerClickHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white24,
        textColor: Colors.blue,
        child: Text(
          answerText,
        ),
        onPressed: answerClickHandler,
      ),
    );
  }
}

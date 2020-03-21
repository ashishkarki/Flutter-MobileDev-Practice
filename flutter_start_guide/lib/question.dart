import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String questionText;

  QuestionWidget(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Text(
      questionText,
    );
  }
}

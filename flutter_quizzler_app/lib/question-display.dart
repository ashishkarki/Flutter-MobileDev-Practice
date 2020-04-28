import 'package:flutter/material.dart';

class QuestionDisplay extends StatelessWidget {
  final String questionText;

  const QuestionDisplay(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            questionText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

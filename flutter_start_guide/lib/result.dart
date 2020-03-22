import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final int totalScore;

  ResultWidget({this.totalScore});

  String get resultDisplayString {
    String resultStr;

    if (totalScore <= 8) {
      resultStr = 'You seem super fabulous awesome';
    } else if (totalScore <= 12) {
      resultStr = 'You seem to be doing Okay';
    } else {
      resultStr = 'What is happening? How do you feel';
    }

    return resultStr;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        resultDisplayString,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

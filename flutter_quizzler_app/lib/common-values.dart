import 'package:flutter/material.dart';
import 'package:quizzler/models/question-model.dart';

enum ResponseButtonType {
  TRUE,
  FALSE,
}

const List<QuestionModel> quizQAList = const [
  QuestionModel('You can lead a cow down stairs but not up stairs.', 'False'),
  QuestionModel(
      'Approximately one quarter of human bones are in the feet.', 'True'),
  QuestionModel('A slug\'s blood is green.', 'True'),
];

const Icon correctResponseIcon = Icon(
  Icons.check,
  color: Colors.green,
);
const Icon incorrectResponseIcon = Icon(
  Icons.close,
  color: Colors.red,
);

String responseButtonStringUtil(ResponseButtonType buttonType) {
  String response = '';
  switch (buttonType) {
    case ResponseButtonType.TRUE:
      response = 'True';
      break;
    case ResponseButtonType.FALSE:
      response = 'False';
      break;
    default:
      response = 'False';
      break;
  }

  return response;
}

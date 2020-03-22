import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class QuizWidget extends StatelessWidget {
  final Function answerClickHandler;
  final int questionIndex;
  final List<Map<String, Object>> questionList;

  QuizWidget(this.answerClickHandler, this.questionList, this.questionIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        QuestionWidget(
          questionList[questionIndex % questionList.length]['questionText'],
        ),
        ...(questionList[questionIndex % questionList.length]['answers']
                as List<Map<String, Object>>)
            .map((Map<String, Object> answerObject) {
          return AnswerWidget(
            () => answerClickHandler(answerObject[
                'score']), // return the result of executing the fxn
            answerObject['text'],
          );
        }).toList(),
      ],
    );
  }
}

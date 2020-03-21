import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';
import './constants.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  final questionList = constantQuestionList;

  void _answerQuestionPressed() {
    setState(() {
      _questionIndex++;
    });
    print('Answer pressed is ' + _questionIndex.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello with better UI'),
        ),
        body: Column(
          children: <Widget>[
            QuestionWidget(
              questionList[_questionIndex % questionList.length]
                  ['questionText'],
            ),
            // AnswerWidget(_answerQuestionPressed),
            // AnswerWidget(_answerQuestionPressed),
            // AnswerWidget(_answerQuestionPressed),
            ...(questionList[_questionIndex % questionList.length]['answers']
                    as List<String>)
                .map((String answer) {
              return AnswerWidget(_answerQuestionPressed, answer);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_start_guide/quiz.dart';
import 'package:flutter_start_guide/result.dart';

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
  final _questionList = constantQuestionList;
  var _totalScore = 0;

  void _answerQuestionPressed(int answerTextScore) {
    _totalScore += answerTextScore;

    setState(() {
      _questionIndex++;
    });
    print('Answer pressed is ' + _questionIndex.toString());
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello with better UI'),
        ),
        body: _questionIndex < _questionList.length
            ? QuizWidget(_answerQuestionPressed, _questionList, _questionIndex)
            : ResultWidget(
                totalScore: _totalScore,
                resetQuizHandler: _resetQuiz,
              ),
      ),
    );
  }
}

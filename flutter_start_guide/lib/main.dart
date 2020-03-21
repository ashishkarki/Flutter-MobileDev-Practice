import 'package:flutter/material.dart';

import './question.dart';

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
  final questionList = [
    'What your mother\'s name?',
    'What is your brother\'s name?',
  ];

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
            Text('The question is: '),
            RaisedButton(
              child: QuestionWidget(
                questionList[_questionIndex % 2],
              ),
              onPressed: _answerQuestionPressed,
            ),
            RaisedButton(
              child: Text('Answer 2'),
              onPressed: _answerQuestionPressed,
            ),
            RaisedButton(
              child: Text('Answer 3'),
              onPressed: _answerQuestionPressed,
            ),
          ],
        ),
      ),
    );
  }
}

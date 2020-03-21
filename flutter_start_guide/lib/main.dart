import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIndex = 0;
  final questionList = [
    'What your mother\'s name?',
    'What is your brother\'s name?',
  ];

  void ansewerQuestionPressed() {
    setState(() {
      questionIndex++;
    });
    print('Answer pressed is ' + questionIndex.toString());
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
              child: Text(
                questionList[questionIndex % 2],
              ),
              onPressed: ansewerQuestionPressed,
            ),
            RaisedButton(
              child: Text('Answer 2'),
              onPressed: ansewerQuestionPressed,
            ),
            RaisedButton(
              child: Text('Answer 3'),
              onPressed: ansewerQuestionPressed,
            ),
          ],
        ),
      ),
    );
  }
}

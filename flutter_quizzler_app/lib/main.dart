import 'package:flutter/material.dart';

import './question-display.dart';
import './selection-button.dart';
import './score-keeper.dart';
import './common-values.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const Icon correctResponseIcon = Icon(
    Icons.check,
    color: Colors.green,
  );
  static const Icon incorrectResponseIcon = Icon(
    Icons.close,
    color: Colors.red,
  );

  List<Icon> scoreKeeper = [];

  int quizQuesandAnsIndex = 0;
  Map<String, String> quizQuesandAnsMap = {
    'You can lead a cow down stairs but not up stairs.': 'False',
    'Approximately one quarter of human bones are in the feet.': 'True',
    'A slug\'s blood is green.': 'True',
    //'YOU ANSWERED ALL QUESTIONS': 'NULL',
  };

  void onResponseButtonPressed(ResponseButtonType buttonType) {
    if (quizQuesandAnsIndex < quizQuesandAnsMap.length) {
      setState(
        () {
          final String correctAnswer =
              quizQuesandAnsMap.values.elementAt(quizQuesandAnsIndex);
          if (responseButtonStringUtil(buttonType).toLowerCase() ==
              correctAnswer.toLowerCase()) {
            scoreKeeper.add(correctResponseIcon);
          } else {
            scoreKeeper.add(incorrectResponseIcon);
          }

          // now update the question index
          quizQuesandAnsIndex++;
          // HACK to prevent index error
          quizQuesandAnsIndex = quizQuesandAnsIndex % quizQuesandAnsMap.length;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (quizQuesandAnsIndex < quizQuesandAnsMap.length)
          QuestionDisplay(
            quizQuesandAnsMap.keys.elementAt(quizQuesandAnsIndex),
          ),
        SelectionButton(
          buttonType: ResponseButtonType.TRUE,
          buttonColor: Colors.green,
          onButtonPressed: onResponseButtonPressed,
        ),
        SelectionButton(
          buttonType: ResponseButtonType.FALSE,
          buttonColor: Colors.red,
          onButtonPressed: onResponseButtonPressed,
        ),
        ScoreKeeper(scoreKeeper),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

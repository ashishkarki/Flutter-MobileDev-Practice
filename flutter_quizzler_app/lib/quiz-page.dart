import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './models/question-model.dart';
import './question-display.dart';
import './selection-button.dart';
import './score-keeper.dart';
import './common-values.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> _scoreKeeper = [];

  int _quizQuesandAnsIndex = 0;
  final List<QuestionModel> _quizQACollection = quizQAList;

  void resetQuiz() {
    setState(() {
      _quizQuesandAnsIndex = 0;
      _scoreKeeper = [];
    });
  }

  void onResponseButtonPressed(ResponseButtonType buttonType) {
    //print('isQuzDone: ${isQuizDone()}');

    //} else {
    setState(() {
      if (responseButtonStringUtil(buttonType).toLowerCase() ==
          _quizQACollection[_quizQuesandAnsIndex]
              .questionAnswer
              .toLowerCase()) {
        _scoreKeeper.add(correctResponseIcon);
      } else {
        _scoreKeeper.add(incorrectResponseIcon);
      }

      // keep clearing scoreKeeper if it grows greater than num. of questions
      if (_scoreKeeper.length > _quizQACollection.length) {
        _scoreKeeper.removeAt(0);
      }

      if (isQuizDone()) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Quiz Finished",
          desc: "Click on the button to reset Quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "Reset Quiz",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                resetQuiz();

                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        // now update the question index
        _quizQuesandAnsIndex++;
      }
    });
    // }
  }

  bool isQuizDone() {
    return _quizQuesandAnsIndex >= _quizQACollection.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //if (quizQuesandAnsIndex < quizQACollection.length)
        QuestionDisplay(
          _quizQACollection[_quizQuesandAnsIndex].questionText,
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
        ScoreKeeper(_scoreKeeper),
      ],
    );
  }
}

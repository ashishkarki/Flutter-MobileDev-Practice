// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text
import 'package:flutter/material.dart';
import 'package:flutter_assignment/bodyText.dart';
import 'package:flutter_assignment/bodyTextControl.dart';
import 'package:flutter_assignment/bodyTextReset.dart';

void main() => runApp(AssignmentApp());

class AssignmentApp extends StatefulWidget {
  @override
  _AssignmentAppState createState() => _AssignmentAppState();
}

class _AssignmentAppState extends State<AssignmentApp> {
  final rollingTexts = [
    'This is FIRST thing',
    'This is SECOND thing',
    'This is THIRD thing',
  ];
  var _textIndex = 0;

  String get rollingBodyTextGetter {
    if (_textIndex < rollingTexts.length) {
      return rollingTexts[_textIndex];
    } else {
      return 'You are DONE with Rolling Texts!!';
    }
  }

  void rollingTextClickHandler() {
    setState(() {
      _textIndex++;
    });
  }

  void resetTextClickHandler() {
    setState(() {
      _textIndex = 0;
    });
  }

  Widget buttonTypeController() {
    return _textIndex < rollingTexts.length
        ? BodyTextControlWidget(rollingTextClickHandler)
        : BodyTextResetWidget(resetTextClickHandler);
  }

  @override
  Widget build(BuildContext context) {
    final rollingTextTemp = rollingBodyTextGetter;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Title of AssignmentApp'),
        ),
        body: Column(
          children: <Widget>[
            BodyTextWidget(rollingTextTemp),
            buttonTypeController(),
          ],
        ),
      ),
    );
  }
}

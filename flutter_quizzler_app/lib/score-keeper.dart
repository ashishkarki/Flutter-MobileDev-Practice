import 'package:flutter/material.dart';

enum ResponseType {
  CORRECT,
  INCORRECT,
}

class ScoreKeeper extends StatelessWidget {
  final List<Icon> scoreKeeper;

  ScoreKeeper(this.scoreKeeper);

  Widget build(BuildContext context) {
    return Row(
      children: scoreKeeper,
    );
  }
}

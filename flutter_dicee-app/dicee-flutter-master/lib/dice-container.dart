import 'dart:math';

import 'package:flutter/material.dart';

enum WhichDie {
  First,
  Second,
}

class DiceContainer extends StatefulWidget {
  @override
  _DiceContainerState createState() => _DiceContainerState();
}

class _DiceContainerState extends State<DiceContainer> {
  int _randomDieIndex1 = 1;
  int _randomDieIndex2 = 6;

  void _getRandomDieIndex({
    WhichDie whichDie = WhichDie.First,
  }) {
    setState(
      () {
        //if (whichDie == WhichDie.First) {
        _randomDieIndex1 = Random().nextInt(6) + 1;
        //} else if (whichDie == WhichDie.Second) {
        _randomDieIndex2 = Random().nextInt(6) + 1;
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // padding: const EdgeInsets.only(
      //   top: 50.0,
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: FlatButton(
              onPressed: () => _getRandomDieIndex(
                whichDie: WhichDie.First,
              ),
              child: Image.asset(
                'images/dice$_randomDieIndex1.png',
                // height: 100,
                // width: 100,
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: () => _getRandomDieIndex(
                whichDie: WhichDie.Second,
              ),
              child: Image.asset(
                'images/dice$_randomDieIndex2.png',
                // height: 100,
                // width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

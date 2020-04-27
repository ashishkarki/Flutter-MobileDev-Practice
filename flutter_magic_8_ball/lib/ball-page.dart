import 'dart:math';

import 'package:flutter/material.dart';

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text('Ask me Anything'),
        backgroundColor: Colors.blue[600],
      ),
      body: Ball(),
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int _magicBallIndex = 1;

  void _onMagicBallPressed() {
    setState(
      () {
        _magicBallIndex = Random().nextInt(5) + 1;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: _onMagicBallPressed,
        child: Image.asset(
          'images/ball$_magicBallIndex.png',
        ),
      ),
    );
  }
}

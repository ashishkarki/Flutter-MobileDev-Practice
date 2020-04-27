import 'package:flutter/material.dart';

class LayoutChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.red,
            width: 100,
            margin: const EdgeInsets.symmetric(vertical: 25),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
              ),
              Container(
                width: 100,
                color: Colors.green,
                height: 100,
              ),
            ],
          ),
          Container(
            width: 100,
            color: Colors.blue,
            margin: const EdgeInsets.symmetric(vertical: 25),
          ),
        ],
      ),
    );
  }
}

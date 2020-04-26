import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('I am poor..'),
        backgroundColor: Colors.black45,
      ),
      body: Center(
        child: Image(
          image: AssetImage('assets/images/i-am-poor_body-icon.png'),
        ),
      ),
    );
  }
}

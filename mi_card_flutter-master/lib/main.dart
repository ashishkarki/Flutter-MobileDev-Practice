import 'package:flutter/material.dart';

import './mi-card-layout.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: MiCardLayout(),
      ),
    );
  }
}

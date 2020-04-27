import 'package:flutter/material.dart';

import './notes-screen.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: NotesScreen(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import './note-list-item.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NoteListItem(
          'note1.wav',
          Colors.amber,
        ),
        NoteListItem(
          'note2.wav',
          Colors.cyan,
        ),
        NoteListItem(
          'note3.wav',
          Colors.red,
        ),
        NoteListItem(
          'note4.wav',
          Colors.blue,
        ),
        NoteListItem(
          'note5.wav',
          Colors.purple,
        ),
        NoteListItem(
          'note6.wav',
          Colors.lightGreen,
        ),
        NoteListItem(
          'note7.wav',
          Colors.pink,
        ),
      ],
    );
  }
}

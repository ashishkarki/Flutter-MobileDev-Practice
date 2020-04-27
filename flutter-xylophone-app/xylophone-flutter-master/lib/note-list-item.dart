import 'package:flutter/material.dart';

import 'audio-player.dart';

class NoteListItem extends StatelessWidget {
  final String noteToPlay;
  final Color noteColor;

  const NoteListItem(this.noteToPlay, this.noteColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50.0,
      color: noteColor,
      child: CustomAudioPlayer(noteToPlay),
    );
  }
}

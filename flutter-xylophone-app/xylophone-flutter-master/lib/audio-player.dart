import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class CustomAudioPlayer extends StatelessWidget {
  final String noteToPlay;
  final Color noteColor;

  const CustomAudioPlayer(this.noteToPlay, this.noteColor);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        color: noteColor,
        onPressed: () {
          final player = AudioCache();
          player.play(noteToPlay);
        },
        child: null,
      ),
    );
  }
}

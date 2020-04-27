import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class CustomAudioPlayer extends StatelessWidget {
  final String noteToPlay;

  const CustomAudioPlayer(this.noteToPlay);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () {
          final player = AudioCache();
          player.play(noteToPlay);
        },
        child: Text('Click to play'),
      ),
    );
  }
}

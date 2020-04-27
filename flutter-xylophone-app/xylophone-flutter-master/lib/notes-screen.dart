import 'package:flutter/material.dart';

import './audio-player.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAudioPlayer(
            'note1.wav',
            Colors.amber,
          ),
          CustomAudioPlayer(
            'note2.wav',
            Colors.cyan,
          ),
          CustomAudioPlayer(
            'note3.wav',
            Colors.red,
          ),
          CustomAudioPlayer(
            'note4.wav',
            Colors.blue,
          ),
          CustomAudioPlayer(
            'note5.wav',
            Colors.purple,
          ),
          CustomAudioPlayer(
            'note6.wav',
            Colors.green,
          ),
          CustomAudioPlayer(
            'note7.wav',
            Colors.pink,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:momt/audio/audioManager.dart';

class MusicPlayer extends StatefulWidget {
  final AudioManager audioManager = new AudioManager();
  MusicPlayer({Key? key}) : super(key: key) {
    audioManager.load(1);
  }
  final List<IconData> playerIcons = [
    Icons.play_arrow_rounded,
    Icons.pause_circle_filled_rounded
  ];

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  int _counter = 0;
  // audioManager.init();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    if (_counter % 2 == 1) {
      widget.audioManager.play();
    } else {
      widget.audioManager.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: _incrementCounter,
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        widget.playerIcons[_counter % 2],
        size: 35.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }
}

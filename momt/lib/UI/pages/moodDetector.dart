import 'package:flutter/material.dart';
import 'package:momt/UI/pages/Login.dart';
import 'package:momt/audio/audioManager.dart';

class MoodDetector extends StatelessWidget {
  MoodDetector({Key? key}) : super(key: key);

  void navigateToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController(initialPage: 0);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("MomT"),
          backgroundColor: Colors.deepPurple,
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              new Container(
                height: 400,
                child: Image.asset("assets/images/moodDetector.png"),
              ),
              new Text(
                'Hello Pranav !',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              new Text(
                'Stressed out. Play music to refresh',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              new MusicPlayer()
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToProfile(context);
          },
          tooltip: 'Next',
          //label: const Text('Skip'),
          child: Icon(
            Icons.arrow_forward,
            size: 40,
          ),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

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

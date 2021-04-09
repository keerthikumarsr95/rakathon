import 'package:flutter/material.dart';
import 'package:momt/UI/pages/LoginNew.dart';

import 'MusicPlayer.dart';

class MoodDetector extends StatelessWidget {
  MoodDetector({Key? key}) : super(key: key);

  void navigateToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginNew()));
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

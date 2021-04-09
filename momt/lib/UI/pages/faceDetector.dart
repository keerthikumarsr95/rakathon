import 'package:flutter/material.dart';
//import 'package:momt/UI/pages/moodDetector.dart';
import 'package:momt/CameraScreen.dart';

class FaceDetector extends StatelessWidget {
  void navigateToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen()));
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        //floatingActionButtonLocation: FloatingActionButtonLocation.,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              new Container(
                height: 500,
                child: Image.asset("assets/images/faceId.png"),
              )
            ])),
        floatingActionButton: Container(
            //width: 100,
            child: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            navigateToProfile(context);
          },
          label: Text(
            'Scan to Start',
            style: TextStyle(fontSize: 20.0),
          ),
          //label: const Text('Skip'),
          icon: Icon(
            Icons.face_unlock_rounded,
            size: 40,
          ),
          backgroundColor: Colors.deepPurple,
        )),
      ),
    );
  }
}

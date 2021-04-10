import 'package:flutter/material.dart';
//import 'package:momt/UI/pages/moodDetector.dart';
//import 'package:momt/CameraScreen.dart';
import 'package:momt/UI/pages/momDashboard.dart';

class MomNotification extends StatelessWidget {
  void navigateToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MomDashboard()));
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              new Container(
                height: 400,
                child: Image.asset("assets/images/q6.png"),
              ),
              new Container(
                  child: Text(
                'Hi Disha !',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    fontFamily: 'RakutenRg'),
              )),
              new Padding(
                padding: EdgeInsets.all(60),
                child: Text(
                  'Congratulations! Your child received golden star in Maths test ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      fontFamily: 'RakutenRg'),
                ),
              ),
            ])),
        floatingActionButton: Container(
            //width: 100,
            child: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            navigateToProfile(context);
          },
          label: Text(
            'NEXT',
            style: TextStyle(fontFamily: 'RakutenRg', fontSize: 20.0),
          ),
          //label: const Text('Skip'),
          // icon: Icon(
          //   Icons.face_unlock_rounded,
          //   size: 40,
          // ),
          backgroundColor: Colors.deepPurple,
        )),
      ),
    );
  }
}

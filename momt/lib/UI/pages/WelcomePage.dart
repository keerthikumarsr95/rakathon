// @dart=2.9
import 'package:flutter/material.dart';
//import 'package:momt/UI/pages/Login.dart';
import 'package:momt/UI/pages/LoginNew.dart';

import 'package:page_view_indicator/page_view_indicator.dart';

class Pages {
  String header, heading, description;
  Pages(this.header, this.heading, this.description);
}

List<Pages> pglist = [
  Pages("Hello", "I'm Momt", "Child's digital companion"),
  Pages(
      "Mom's Assistant", "", "Track child's activities, progress at one place"),
  Pages("Teacher's  Associate", "", "Manage assignments, schedules & more")
];

class WelcomeNew extends StatelessWidget {
  static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(0);

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
        body: Stack(
          alignment: FractionalOffset.bottomCenter,
          children: <Widget>[
            PageView.builder(
              onPageChanged: (index) => pageIndexNotifier.value = index,
              itemCount: length,
              itemBuilder: (context, index) {
                return _introPage(pglist[index]);
              },
            ),
            _indicator()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            navigateToProfile(context);
          },
          tooltip: 'Skip',
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

  Center _introPage(page) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 100.0,
                      height: 160.0,
                      child: Image.asset("assets/images/momt2.png")),
                  new Text(page.header,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'Open Sans')),
                  new Text(page.heading,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 25.0,
                          fontFamily: 'Open Sans')),
                  new Text(page.description,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 25.0,
                          fontFamily: 'Open Sans'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageViewIndicator _indicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.deepPurple.shade200,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

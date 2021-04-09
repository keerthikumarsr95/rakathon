import 'package:flutter/material.dart';
//import 'Login/LoginPage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Center(
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
                      new Text("Hello !",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 50.0,
                              fontFamily: 'Open Sans')),
                      new Text("I'm MomT",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontSize: 25.0,
                              fontFamily: 'Open Sans')),
                      new Text('Your digital buddy',
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              //label: const Text('Skip'),
              child: Icon(
                Icons.arrow_forward,
                size: 40,
              ),
              backgroundColor: Colors.deepPurple,
            ),
          ),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        )
      ],
    );
  }
}

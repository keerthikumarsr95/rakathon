import 'package:flutter/material.dart';
import 'package:momt/UI/ChatBot/BotUI.dart';

class MomDashboard extends StatelessWidget {
  // void navigateToProfile(BuildContext context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (_) => ConversationalBot()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Container(
            width: 80.0,
            height: 80.0,
            child: new RawMaterialButton(
              elevation: 2.0,
              shape: new CircleBorder(),
              fillColor: Colors.deepPurple,
              child: Image.asset('assets/images/momtBot.png', fit: BoxFit.fill),
              onPressed: () {
                // navigateToProfile(context);
              },
            )),
      ),
      body: ListView(
        children: [
          Image.asset(
            "assets/images/momDashboard2.png",
            fit: BoxFit.fitWidth,
            // width: 720,
          ),
        ],
      ),
    );
  }
}

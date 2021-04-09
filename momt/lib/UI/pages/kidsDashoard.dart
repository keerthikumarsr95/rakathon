import 'package:flutter/material.dart';
import 'package:momt/conversation/conversationManager.dart';

class KidsDashboard extends StatelessWidget {

  KidsDashboard(){
    ConversationManager.instance.start();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            "assets/images/kids_dashboard.jpg",
            fit: BoxFit.fitWidth,
            // width: 720,
          ),
        ],
      ),
    );
  }
}

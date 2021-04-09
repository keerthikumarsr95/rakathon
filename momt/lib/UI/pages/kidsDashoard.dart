import 'package:flutter/material.dart';

class KidsDashboard extends StatelessWidget {
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

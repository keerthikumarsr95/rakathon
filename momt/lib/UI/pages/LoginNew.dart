import 'package:flutter/material.dart';
import 'package:momt/UI/pages/faceDetector.dart';
import 'package:momt/UI/pages/momDashboard.dart';

class LoginNew extends StatelessWidget {
  void navigateToProfile(BuildContext context, index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => index == 2 ? FaceDetector() : MomDashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        title: Text('MoMT'),
      ),
      body: Stack(
        fit: StackFit.expand,
        //alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      width: 80.0,
                      height: 120.0,
                      child: Image.asset("assets/images/momt2.png")),
                  new Text('Sign in as',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30.0,
                          fontFamily: 'RakutenRg')),
                ]),
          ),
          new GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            padding: EdgeInsets.symmetric(vertical: 260.0),
            children: List.generate(4, (index) {
              return GestureDetector(
                  onTap: () {
                    navigateToProfile(context, index);
                  },
                  child: ProfileCard(index: index));
            }),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  //const ProfileCard({Key? key}) : super(key: key);
  final int index;
  ProfileCard({required this.index});
  final List<String> entries = <String>['Teacher', 'Mom', 'Student', 'Admin'];
  final List<MaterialColor> colors = <MaterialColor>[
    Colors.deepPurple,
    Colors.pink,
    Colors.blue,
    Colors.orange
  ];
  final List<IconData> categories = <IconData>[
    Icons.person_outline_rounded,
    Icons.home_outlined,
    Icons.person,
    Icons.laptop_mac_outlined
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: 120.0,
              height: 120.0,
              child: Image.asset('assets/images/${entries[index]}.png'),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: colors[index],
              )),
          Text(entries[index],
              style: TextStyle(
                  fontFamily: 'RakutenRg',
                  fontWeight: FontWeight.bold,
                  //color: Colors.white,
                  fontSize: 20.0)),
        ],
      ),
    );
  }
}

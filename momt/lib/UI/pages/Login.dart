import 'package:flutter/material.dart';
import 'package:momt/UI/pages/faceDetector.dart';

class Login extends StatelessWidget {
  void navigateToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => FaceDetector()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        title: Text('MoMT'),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        padding: EdgeInsets.symmetric(vertical: 60.0),
        children: List.generate(4, (index) {
          return GestureDetector(
              onTap: () {
                if (index == 2) navigateToProfile(context);
              },
              child: ProfileCard(index: index));
        }),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  //const ProfileCard({Key? key}) : super(key: key);
  final int index;
  ProfileCard({required this.index});
  final List<String> entries = <String>['Teacher', 'Mom', 'Student', 'Admin'];
  final List<IconData> categories = <IconData>[
    Icons.person_outline_rounded,
    Icons.home_outlined,
    Icons.person,
    Icons.laptop_mac_outlined
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200.0,
        child: Card(
          color: Colors.accents[index],
          shadowColor: Colors.grey,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.deepPurpleAccent,
                              blurRadius: 10.0,
                            ),
                          ],
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new ExactAssetImage(
                                  'assets/images/${entries[index]}.png'))))),
              Text(entries[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}

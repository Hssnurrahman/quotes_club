import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile-screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Map userData = {};

  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;

    print(
      userData,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Sansita Swashed Regular",
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Center(
          child: Column(
            children: [

              // SizedBox(
              //   height: 10,
              // ),
              // RaisedButton.icon(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(
              //       10,
              //     ),
              //   ),
              //   onPressed: () async {
              //     print(
              //       "Log Out Button Pressed",
              //     );
              //
              //     await _googleSignIn.signOut();
              //     await FirebaseAuth.instance.signOut();
              //   },
              //   icon: Icon(
              //     Icons.exit_to_app,
              //     size: 18,
              //     color: Colors.white,
              //   ),
              //   label: Text(
              //     "Log Out",
              //     style: TextStyle(
              //       fontSize: 17,
              //       fontFamily: "Ubuntu",
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

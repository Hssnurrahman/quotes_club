import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app/screens/privacy_policy_screen.dart';
import 'package:quotes_app/screens/tabs_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = "/welcome-screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isSigningIn = false;

  googleSignIn() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return showToast(
        "Please Connect To Internet To Sign In With Google",
      );
    }

    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        setState(() {
          _isSigningIn = true;
        });

        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(
          credential,
        );

        final user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection("users").doc(user?.uid).set(
          {
            "userName": user?.displayName,
            "userEmail": user?.email,
            "userId": user?.uid,
          },
        );

        Navigator.of(context).pushReplacementNamed(
          TabsScreen.routeName,
        );
      }

      setState(() {
        _isSigningIn = false;
      });
    } on PlatformException catch (error) {
      print(
        "Error While Signing In With Google: ${error.message}",
      );

      showToast(
        "Please Connect To Internet To Create Account With Google!",
      );

      setState(() {
        _isSigningIn = false;
      });
    }
  }

  // InterstitialAd _interstitialAd;

  // @override
  // void dispose() {
  //   super.dispose();

  //   _interstitialAd.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: _isSigningIn == true
            ? CircularProgressIndicator(
                color: Colors.teal,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assests/images/quotes_app_icon.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Text(
                    "Quotes Club",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Sansita Swashed Regular",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Welcome To Quotes Club!",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Ubuntu",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "This App Includes Features Like These:",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Ubuntu",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1-   You Can Read Quote.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2-   You Can Own Add Quote.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "3-   You Can Copy Quote.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "4-   You Can Share Quote Everywhere.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You Can Read",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PrivacyPolicyScreen.routeName,
                          );
                        },
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Ubuntu",
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Of This App",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.teal,
                        ),
                      ),
                      onPressed: googleSignIn,
                      child: Text(
                        "Sign In With Google",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Ubuntu",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

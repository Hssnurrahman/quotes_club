import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/screens/privacy_policy_screen.dart';
import 'package:quotes_app/screens/user_guide_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = "/welcome-screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  InterstitialAd _interstitialAd;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
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
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(
                    10,
                  ),
                ),
                onPressed: () async {
                  FirebaseAdMob.instance.initialize(
                    appId: "ca-app-pub-2589764057313070~2847928533",
                  );

                  _interstitialAd = InterstitialAd(
                      adUnitId: "ca-app-pub-2589764057313070/5479946835",
                      listener: (MobileAdEvent mobileAdEvent) {
                        print(
                          "Interstitial Ad : $mobileAdEvent",
                        );
                      });

                  Navigator.of(context).pushReplacementNamed(
                    UserGuideScreen.routeName,
                  );
                },
                child: Text(
                  "Read User Guide",
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

import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quotes_app/screens/feedback_screen.dart';
import 'package:quotes_app/screens/welcome_screen.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/divider.dart';
import 'package:quotes_app/widgets/list_tile.dart';
import 'package:quotes_app/widgets/sized_box.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'whats_new_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings-screen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  final _userData = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuotesAppBar().appBar(
        "Settings",
        true,
        FlatButton(onPressed: null, child: null),
      ),
      body: Container(
        padding: EdgeInsets.all(
          15,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "You Are Logged In!",
                style: TextStyle(
                  fontSize: 19,
                  fontFamily: "Ubuntu",
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Name: ${_userData.displayName}",
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "Ubuntu",
                  color: Colors.black,
                ),
              ),
              QuoteSizedBox().settingsSizedBox(
                10,
              ),
              Text(
                "Email: ${_userData.email}",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Ubuntu",
                  color: Colors.black,
                ),
              ),
              QuoteSizedBox().settingsSizedBox(
                20,
              ),
              QuoteListTile().settingsListTileWithText(
                Icons.phone_android,
                "Version",
                "1.0.1",
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              QuoteListTile().settingsListTileWithRichTextIcon(
                () {
                  Navigator.of(context).pushNamed(
                    WhatsNewScreen.routeName,
                  );
                },
                Icons.add_circle_outline,
                "What's New",
                Icons.arrow_forward_ios,
                () {
                  Navigator.of(context).pushNamed(
                    WhatsNewScreen.routeName,
                  );
                },
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              QuoteListTile().settingsListTileWithIcon(
                () {
                  Navigator.of(context).pushNamed(
                    FeedbackScreen.routeName,
                  );
                },
                Icons.feedback,
                "Feedback",
                Icons.arrow_forward_ios,
                () {
                  Navigator.of(context).pushNamed(
                    FeedbackScreen.routeName,
                  );
                },
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              ListTile(
                onTap: () {
                  Share.share(
                    "Read Daily Unlimited Awesome Quotes Through Quotes Club, Link Given Below:\n\nhttps://play.google.com/store/apps/details?id=com.hassan.quotes_club",
                  );
                },
                leading: Icon(
                  Icons.share,
                  color: Theme.of(context).iconTheme.color,
                  size: 20,
                ),
                title: Text(
                  "Share App",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              ListTile(
                onTap: () async {
                  var url =
                      "https://play.google.com/store/apps/details?id=com.hassan.quotes_club";
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                    );
                  } else {
                    throw "Could not Open Link";
                  }
                },
                leading: Icon(
                  Icons.star_rate,
                  color: Theme.of(context).iconTheme.color,
                  size: 20,
                ),
                title: Text(
                  "Rate App",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              ListTile(
                onTap: () async {
                  await _googleSignIn.signOut();
                  await FirebaseAuth.instance.signOut();

                  Navigator.of(context).pushReplacementNamed(
                    WelcomeScreen.routeName,
                  );
                },
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).iconTheme.color,
                  size: 20,
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

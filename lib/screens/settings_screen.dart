import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quotes_app/screens/feedback_screen.dart';
import 'package:quotes_app/screens/user_guide_screen.dart';
import 'package:quotes_app/screens/welcome_screen.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/divider.dart';
import 'package:quotes_app/widgets/list_tile.dart';
import 'package:quotes_app/widgets/sized_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

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
      backgroundColor: Colors.grey[300],
      appBar: QuotesAppBar().appBar(
        "Settings",
        true,
      ),
      body: Container(
        padding: EdgeInsets.all(
          15,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  (_userData?.photoURL).toString(),
                ),
                radius: 40,
                backgroundColor: Colors.teal,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Name: ${_userData?.displayName}",
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
                "Email: ${_userData?.email}",
                style: TextStyle(
                  fontSize: 17,
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
                "1.0.2",
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
              QuoteListTile().settingsListTileWithIcon(
                () {
                  Navigator.of(context).pushNamed(
                    UserGuideScreen.routeName,
                  );
                },
                Icons.book,
                "User Guide",
                Icons.arrow_forward_ios,
                () {
                  Navigator.of(context).pushNamed(
                    UserGuideScreen.routeName,
                  );
                },
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              QuoteListTile().settingsListTile(
                icon: Icons.share,
                titleText: "Share",
                onTap: () {
                  Share.share(
                    "Read Daily Unlimited Awesome Quotes Through Quotes Club, Link Given Below:\n\nhttps://play.google.com/store/apps/details?id=com.hassan.quotes_club",
                  );
                },
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              QuoteListTile().settingsListTile(
                icon: Icons.star,
                titleText: "Rate",
                onTap: () async {
                  Uri url = Uri.parse(
                    "https://play.google.com/store/apps/details?id=com.hassan.quotes_club",
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                    );
                  } else {
                    throw "Could not Open Link";
                  }
                },
              ),
              QuoteDivider().settingsDivider(
                context,
              ),
              QuoteListTile().settingsListTile(
                icon: Icons.exit_to_app,
                titleText: "Logout",
                onTap: () async {
                  await _googleSignIn.signOut();
                  await FirebaseAuth.instance.signOut();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

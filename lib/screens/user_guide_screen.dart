import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app/screens/tabs_screen.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/divider.dart';
import 'package:quotes_app/widgets/list_tile.dart';

class UserGuideScreen extends StatefulWidget {
  static const routeName = "/user-guide-screen";

  @override
  _UserGuideScreenState createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> {
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
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

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

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set(
          {
            "userName": user.displayName,
            "userEmail": user.email,
            "userId": user.uid,
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

      if (error.code != null) {
        showToast(
          "Please Connect To Internet To Create Account With Google!",
        );

        setState(() {
          _isSigningIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuotesAppBar().appBar(
        "User Guide",
        true,
        FlatButton(
          onPressed: null,
          child: null,
        ),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height * 0.705,
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).size.height * 0.13,
        ),
        child: SingleChildScrollView(
          child: _isSigningIn
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    QuoteListTile().userGuideListTile(
                      "01",
                      "What Is Quotes Club?",
                      """Quotes Club Is App In Which\n1-   You Can Read and Add Unlimited Amount of Quotes.\n2-   You Can Easily Copy & Share A Quote Anywhere.\n3-   You Can See Your Added Quotes In the 'My Quotes' Section.\n4- At Start, Only 06 Quotes Are Visible. When You Click On the 'Load More' Button, More Quotes Are Made Available To You.""",
                      // "The Purpose Of This App To Make The Large Collection Of Good Quotes In Which User Can Add Their Favorite Quote. Only 06 Quotes Are Available When You First Run The App But If You Want More Then Click On Load More, More Quotes Are Available To You.",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "02",
                      "What Is Purpose Of Making This App?",
                      """1-   The Main Purpose Of Making This App Is To Make The Large Collection Of Good And Best Quotes.\n2-   The Best Part Of This App Is That You Can Also Add Your Favorite Quotes In This App.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "03",
                      "How Can You Create Account In Quotes Club?",
                      """1-   When You Read User's Guide Completely, Click On 'Sign In With Google' Button.\n2-   It Asks For Your Gmail Account.\n3-   After Selecting, It Automatically Signs You In.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "04",
                      "How To Read Unlimited Quotes In Quotes Club?",
                      """1-   At Start Only 06 Quotes Are Available.\n2-   After That, You See A Button 'Load More', Click On It To Load Further Quotes.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "05",
                      "How To Copy & Share A Quote On All Other Apps?",
                      """1-   Every Quote Has A Copy & Share Button Under It.\n2-   It's Very Easy To Share & Copy Just Tap On These Buttons.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "06",
                      "How To Add A Quote In Quotes Club?",
                      """1-   Tap on Add Quote Button From Bottom Navigation Bar.\n2-   Then, Write Quote Which You Want To Add To the Given Space.\n3- Enter The Author Name  Only If You Know, You Can Leave This Place Blank.\n4-  Select Quote Category Because It Is Necessary.\n5-  Select Quote Language, Default Is English.\n6-  Then Click On Submit.\n7- Wow, Your Quote Has Been Added!
                      """,
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "07",
                      "How Can You See Your Quote In Quotes Club?",
                      """1-   At Start Only 06 Quotes Are Available.\n2-   After That, You See A Button 'Load More', Click On It To Load further Quotes.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "08",
                      "How To Check What's New In This Version Of Quotes Club?",
                      """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On What'sNew In Settings And Here You Can Read What's New In This Version.
                      """,
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "09",
                      "How To Give Feedback About Quotes Club?",
                      """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On Feedback In Settings And Here You Have To Tap On Give Feedback And It Is Necessary Because It Helps Us To Improve Our App.
                      """,
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "10",
                      "How To Report A Bug In Quotes Club?",
                      """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On Feedback And Here Again Go Into Feedback And Here Is Option To Report A Bug. When You Click On This, Fill Form If Any Error Occurs.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "11",
                      "How Can You Contact With Us In Quotes Club?",
                      """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On Feedback And Here Again Go Into Feedback And Here Is Option To Contact Us On Email. Send Us A Message, We Will Reply As Soon As Possible In Sha Allah.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    QuoteListTile().userGuideListTile(
                      "12",
                      "How To Log Out From Quotes Club?",
                      """1-   Go Into Settings, Then You See A Log Out Button Simply Tap On It.""",
                    ),
                    QuoteDivider().userGuideDivider(),
                    Text(
                      "If You Have More Question That Aren't Added, Go To 'Contact Us' And Message Us Or If You Have Any Problem Then Fill Report Bug Form Or Email Us So That Your Problem Will Be Solved. Hope That You Enjoyed Our App!",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Ubuntu",
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: _isSigningIn
          ? Container()
          : FloatingActionButton.extended(
              onPressed: googleSignIn,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              elevation: 5,
              label: Text(
                "Sign In With Google",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: "Ubuntu",
                ),
              ),
            ),
    );
  }
}

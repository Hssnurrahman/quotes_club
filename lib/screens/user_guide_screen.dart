import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/divider.dart';
import 'package:quotes_app/widgets/list_tile.dart';

class UserGuideScreen extends StatefulWidget {
  static const routeName = "/user-guide-screen";

  @override
  _UserGuideScreenState createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: QuotesAppBar().appBar(
        "User Guide",
        true,
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height * 0.705,
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              QuoteListTile().userGuideListTile(
                "01",
                "What Is Quotes Club?",
                """Quotes Club Is App In Which\n1-   You Can Read and Add Unlimited Amount of Quotes.\n2-   You Can Easily Copy & Share A Quote Anywhere.\n3-   You Can Translate Quote From English To Urdu and Vice Versa.\n4-   You Can See Your Added Quotes In the 'My Quotes' Section.""",
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
                """1-   Click On 'Sign In With google' Button On Welcome Screen.\n2-   It Asks For Your Gmail Account, Select and Sign In.""",
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "04",
                "How To Copy & Share A Quote On All Other Apps?",
                """1-   Every Quote Has A Copy & Share Button Under It.\n2-   It's Very Easy To Share & Copy Just Tap On These Buttons.""",
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "05",
                "How To Translate A Quote?",
                """1-   Every Quote Has A Translate Button Under It.\n2-   Just Tap On Button You See Translation From English To Urdu and Vice Versa.""",
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "06",
                "How To See Quotes That Are Added By Any Creator At One Place?",
                """1-   Just Tab On Any Creator Name To See List Of All Quotes Added By Him.""",
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "07",
                "How To Add A Quote In Quotes Club?",
                """1-   Tap on Add Quote Button From Bottom Navigation Bar.\n2-   Then, Write Quote Which You Want To Add.\n3- Enter The Author Name  Only If You Know, You Can Leave This Place Blank.\n4-  Select Quote Category, Default Is Life.\n5-  Select Quote Language, Default Is English.\n6-  Then Click On Submit.\n7- Wow, Your Quote Has Been Added!
                      """,
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "08",
                "How Can You See Your Quote In Quotes Club?",
                """1-   Click On My Quotes From Bottom Navigation Bar To See Your All Quotes.""",
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "09",
                "How To Check What's New In This Version Of Quotes Club?",
                """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On What's New In Settings And Here You Can Read What's New In This Version.
                      """,
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "10",
                "How To Give Feedback About Quotes Club?",
                """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On Feedback In Settings And Here You Have To Tap On Give Feedback And It Is Necessary Because It Helps Us To Improve Our App.
                      """,
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "11",
                "How To Report A Bug In Quotes Club?",
                """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On Feedback And Here Again Go Into Feedback And Here Is Option To Report A Bug. When You Click On This, Fill Form If Any Error Occurs.""",
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "12",
                "How Can You Contact With Us In Quotes Club?",
                """1-   Tap on Settings Button From Bottom Navigation Bar.\n2-   Then, Tap On Feedback And Here Again Go Into Feedback And Here Is Option To Contact Us On Email. Send Us A Message, We Will Reply As Soon As Possible In Sha Allah.""",
              ),
              QuoteDivider().userGuideDivider(),
              QuoteListTile().userGuideListTile(
                "13",
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/divider.dart';
import 'package:quotes_app/widgets/list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackScreen extends StatelessWidget {
  static const routeName = "/feedback-screen";

  @override
  Widget build(BuildContext context) {
    Widget buildListTile(
      String link,
      IconData iconData,
      String titleText,
    ) {
      return ListTile(
        onTap: () async {
          var url = link;
          if (await canLaunch(url)) {
            await launch(
              url,
            );
          } else {
            throw "Could not Open Link";
          }
        },
        leading: Icon(
          iconData,
          size: 29,
          color: Colors.teal,
        ),
        title: Text(
          titleText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontFamily: "Ubuntu",
          ),
        ),
      );
    }

    return Scaffold(
      appBar: QuotesAppBar().appBar(
        "Feedback",
        true,
        FlatButton(
          onPressed: null,
          child: null,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildListTile(
              "https://forms.gle/8qGZVYV8i81NRc2p6",
              Icons.feedback,
              "Give Feedback",
            ),
            Divider(),
            buildListTile(
              "https://forms.gle/toJq5znnz4HxBCDMA",
              Icons.report,
              "Report A Bug",
            ),
            Divider(),
            buildListTile(
              "mailto:hssnurrahman@gmail.com",
              Icons.contact_mail,
              "Contact Us",
            ),
          ],
        ),
      ),
    );
  }
}

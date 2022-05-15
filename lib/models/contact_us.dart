import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  void sendEmail() async {
    Uri url = Uri.parse("mailto:quotesclub02@gmail.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    } else {
      throw "Could not Open Email";
    }
  }

//  void sendWhatsApp() async {
//    var url = "https://web.whatsapp.com/";
//    await canLaunch(url) ? launch(url) : print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Welcome To",
              style: TextStyle(fontSize: 25, fontFamily: "Ubuntu"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "QuotesApp",
              style: TextStyle(fontSize: 25, fontFamily: "Ubuntu"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "If You Have",
              style: TextStyle(fontSize: 20, fontFamily: "Ubuntu"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Any Problem Or Suggestion",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Ubuntu",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Related To This App",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Ubuntu",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Contact Us On This Email:",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Ubuntu",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: sendEmail,
              child: Text(
                "Send Email",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  fontFamily: "Ubuntu",
                ),
              ),
            ),
//            Text(
//              "or",
//              style: TextStyle(
//                fontSize: 20,
//              ),
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            Text(
//              "WhatsApp Us at:",
//              style: TextStyle(
//                fontSize: 20,
//              ),
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            GestureDetector(
//              onTap: sendWhatsApp,
//              child: Text(
//                "0302-6658022",
//                style: TextStyle(
//                  decoration: TextDecoration.underline,
//                  fontSize: 20,
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}

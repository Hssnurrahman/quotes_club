import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhatsNew extends StatelessWidget {
  Widget buildWhatsNewPage(String new1, context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Text(
        new1,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontFamily: "Ubuntu",
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "What's New",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontFamily: "Ubuntu",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "V 1.0.0",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontFamily: "Ubuntu",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildWhatsNewPage(
                    "1-    Add Quotes As Much As You Can With 8 Categories!",
                    context,
                  ),
                  buildWhatsNewPage(
                    "2-    You Can See Your Added Quotes In My Quotes Section.",
                    context,
                  ),
                  buildWhatsNewPage(
                    "3-    Copy & Share Quotes As Many & Where You Want.",
                    context,
                  ),
                  buildWhatsNewPage(
                    "4-    User Guide Is Available Where You Read How App Works.",
                    context,
                  ),
                  Text(
                    "What's New",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "V 1.0.1",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  buildWhatsNewPage(
                    "1-    Google Sign In Bug Fixed!",
                    context,
                  ),
                ],
              ),

              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   "What's New",
              //   style: TextStyle(
              //     fontSize: 25,
              //     color: Theme.of(context).textTheme.subtitle1.color,
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   "V 1.0.2",
              //   style: TextStyle(
              //     fontSize: 25,
              //     color: Theme.of(context).textTheme.subtitle1.color,
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Divider(),
              // SizedBox(
              //   height: 10,
              // ),
              // buildWhatsNewPage(
              //   "More quotes added!",
              //   Theme.of(context).textTheme.subtitle1,
              //   context,
              // ),
              // buildWhatsNewPage(
              //   "Contact Us added",
              //   Theme.of(context).textTheme.subtitle1,
              //   context,
              // ),
              // buildWhatsNewPage(
              //   "Search option added",
              //   Theme.of(context).textTheme.subtitle1,
              //   context,
              // ),
              // buildWhatsNewPage(
              //   "Pop up menu added",
              //   Theme.of(context).textTheme.subtitle1,
              //   context,
              // ),
              // buildWhatsNewPage(
              //   "Make app litter bit responsive",
              //   Theme.of(context).textTheme.subtitle1,
              //   context,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

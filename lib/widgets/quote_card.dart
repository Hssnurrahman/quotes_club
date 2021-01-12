import 'dart:ui' as ui;

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app/widgets/divider.dart';
import 'package:quotes_app/widgets/sized_box.dart';
import 'package:share/share.dart';

class QuotesCard {
  Card quoteCard(
    BuildContext context,
    List<DocumentSnapshot> quotes,
    int index,
    dynamic createdDate,
    String language,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      elevation: 5,
      color: Colors.grey[700],
      child: Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                print(
                  quotes[index].data()["creatorName"],
                );
              },
              child: Text(
                quotes[index].data()["creatorName"],
                style: TextStyle(
                  fontFamily: "A Anti Corona",
                  fontSize: 14,
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            QuoteSizedBox().quotesSizedBox(
              10,
              0,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  quotes[index].data()["quote"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    fontSize: 18,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                  textDirection: language == "Urdu" || language == "Arabic"
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                ),
              ),
            ),
            QuoteSizedBox().quotesSizedBox(
              10,
              0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Author: ${quotes[index].data()["authorName"]}",
                  style: TextStyle(
                    fontFamily: "A Anti Corona",
                    fontSize: 12.5,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Time: ${DateFormat.d().format(
                        createdDate.toDate(),
                      ) == DateFormat.d().format(
                        DateTime.now(),
                      ) ? "Today, " + DateFormat.jm().format(
                        createdDate.toDate(),
                      ) : DateFormat.y().format(
                        createdDate.toDate(),
                      ) == DateFormat.y().format(
                        DateTime.now(),
                      ) ? DateFormat.MMMd().format(
                        createdDate.toDate(),
                      ) + "," + " " + DateFormat.jm().format(
                        createdDate.toDate(),
                      ) : DateFormat.yMMMd().format(
                        createdDate.toDate(),
                      ) + "," + " " + DateFormat.jm().format(
                        createdDate.toDate(),
                      )}",
                  style: TextStyle(
                    fontFamily: "A Anti Corona",
                    fontSize: 12.5,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            QuoteDivider().quotesDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Share.share(
                      """${quotes[index].data()['quote']}""",
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      QuoteSizedBox().quotesSizedBox(
                        5,
                        0,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontSize: 14,
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                QuoteSizedBox().quotesSizedBox(
                  0,
                  MediaQuery.of(context).size.width * 0.3,
                ),
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(
                      quotes[index].data()["quote"],
                    );

                    showToast(
                      "Quote Copied!",
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.copy,
                        color: Colors.white,
                      ),
                      QuoteSizedBox().quotesSizedBox(
                        0,
                        5,
                      ),
                      Text(
                        "Copy",
                        style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontSize: 14,
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer(),
                // Icon(
                //   Icons.favorite_border,
                //   color: Colors.white,
                // ),
                // SizedBox(
                //   width: 5,
                // ),
                // Text(
                //   "Favorite",
                //   style: TextStyle(
                //     fontFamily: "Ubuntu",
                //     fontSize: 14,
                //     color: Colors.white,
                //     // fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

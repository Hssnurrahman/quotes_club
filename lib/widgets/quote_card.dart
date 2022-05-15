import 'dart:ui' as ui;

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app/screens/creator_quotes_screen.dart';
import 'package:quotes_app/widgets/divider.dart';
import 'package:quotes_app/widgets/sized_box.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/translator.dart';

class QuotesCard extends StatefulWidget {
  final String? quote;

  final String? creatorName;

  final String? authorName;

  final String? language;

  final dynamic createdDate;

  QuotesCard({
    Key? key,
    this.quote,
    this.creatorName,
    this.authorName,
    this.language,
    this.createdDate,
  }) : super(key: key);

  @override
  State<QuotesCard> createState() => _QuotesCardState();
}

class _QuotesCardState extends State<QuotesCard> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(translation) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Translation',
              style: TextStyle(
                fontFamily: "Sansita Swashed Regular",
                fontSize: 20,
              ),
            ),
            content: Text(
              '$translation',
              style: TextStyle(
                fontFamily: "Ubuntu",
                fontSize: 17,
              ),
              textDirection:
                  widget.language == "Urdu" || widget.language == "Arabic"
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.grey[300],
            actions: <Widget>[
              // TextButton(
              //   style: ButtonStyle(
              //       foregroundColor: MaterialStateProperty.all(
              //     Colors.teal,
              //   )),
              //   child: const Text(
              //     'Copy',
              //   ),
              //   onPressed: () {
              //     print("Quote Copies");
              //     FlutterClipboard.copy(
              //       translation as Translation,
              //     );

              //     Navigator.of(context).pop();
              //     showToast(
              //       "Quote Copied!",
              //     );
              //   },
              // ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    Colors.teal,
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontFamily: "A Anti Corona",
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreatorQuotesScreen(
                      creatorName: widget.creatorName,
                    ),
                  ),
                );
              },
              child: Text(
                widget.creatorName!,
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
                  widget.quote!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    fontSize: 17,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                  textDirection:
                      widget.language == "Urdu" || widget.language == "Arabic"
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
                  "Author: ${widget.authorName!}",
                  style: TextStyle(
                    fontFamily: "A Anti Corona",
                    fontSize: 12.5,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Time: ${DateFormat.d().format(
                        widget.createdDate.toDate(),
                      ) == DateFormat.d().format(
                        DateTime.now(),
                      ) ? "Today, " + DateFormat.jm().format(
                        widget.createdDate.toDate(),
                      ) : DateFormat.y().format(
                        widget.createdDate.toDate(),
                      ) == DateFormat.y().format(
                        DateTime.now(),
                      ) ? DateFormat.MMMd().format(
                        widget.createdDate.toDate(),
                      ) + "," + " " + DateFormat.jm().format(
                        widget.createdDate.toDate(),
                      ) : DateFormat.yMMMd().format(
                        widget.createdDate.toDate(),
                      ) + "," + " " + DateFormat.jm().format(
                        widget.createdDate.toDate(),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Share.share(
                      """$widget.quote""",
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 14,
                      ),
                      QuoteSizedBox().quotesSizedBox(
                        0,
                        5,
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
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(
                      widget.quote!,
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
                        size: 14,
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
                InkWell(
                  onTap: () async {
                    final translator = GoogleTranslator();

                    Translation? translation = await translator.translate(
                      widget.quote!,
                      to: widget.language == 'English' ? 'ur' : 'en',
                    );

                    print(translation);

                    _showMyDialog(translation);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.translate,
                        color: Colors.white,
                        size: 14,
                      ),
                      QuoteSizedBox().quotesSizedBox(
                        0,
                        5,
                      ),
                      Text(
                        "Translate",
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

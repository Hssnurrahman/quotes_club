import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/models/quote_card.dart';

import 'package:quotes_app/widgets/app_bar.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuotesAppBar().appBar(
        "Quotes Club",
        false,
        FlatButton(onPressed: null, child: null),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          bottom: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          child: QuoteCard(),
        ),
      ),
    );
  }
}

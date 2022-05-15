import 'package:flutter/material.dart';
import 'package:quotes_app/screens/quotes_screen.dart';

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
      backgroundColor: Colors.grey[300],
      appBar: QuotesAppBar().appBar(
        "Quotes Club",
        false,
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          bottom: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          child: QuotesScreen(),
        ),
      ),
    );
  }
}

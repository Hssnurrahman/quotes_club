import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/models/add_quote.dart';
import 'package:quotes_app/screens/my_quotes_screen.dart';
import 'package:quotes_app/widgets/bottom_navigation_bar.dart';

import 'main_screen.dart';
import 'settings_screen.dart';

enum differentData {
  Facts,
  SettingsScreen,
}

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs-screen";

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  PageController _pageController = PageController();



  List<Widget> pages = [
    MainScreen(),
    AddQuote(),
    MyQuotesScreen(),
    SettingsScreen(),
  ];

  int selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  animateToPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: Duration(
        milliseconds: 500,
      ),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: PageView(
        children: pages,
        onPageChanged: selectPage,
        controller: _pageController,
      ),
      bottomNavigationBar: QuotesBottomNavigationBar().bottomNavigationBar(
        selectedPageIndex,
        animateToPage,
      ),
    );
  }
}

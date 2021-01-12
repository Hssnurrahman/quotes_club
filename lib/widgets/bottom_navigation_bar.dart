import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class QuotesBottomNavigationBar {
  SnakeNavigationBar bottomNavigationBar(
    int selectedPageIndex,
    Function animateToPage,
  ) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.indicator,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(
      //       20,
      //     ),
      //   ),
      // ),

      ///configuration for SnakeNavigationBar.color
      snakeViewColor: Colors.white,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,

      backgroundColor: Colors.teal,

      ///configuration for SnakeNavigationBar.gradient
      // snakeViewGradient: LinearGradient(
      //   colors: [
      //     Colors.red,
      //     Colors.blue,
      //   ],
      // ),
      // selectedItemGradient: LinearGradient(
      //   colors: [
      //     Colors.red,
      //     Colors.blue,
      //   ],
      // ),
      // unselectedItemGradient: LinearGradient(
      //   colors: [
      //     Colors.red,
      //     Colors.blue,
      //   ],
      // ),

      showUnselectedLabels: false,
      showSelectedLabels: true,

      selectedLabelStyle: TextStyle(
        fontSize: 13.5,
        fontFamily: "Ubuntu",
      ),

      currentIndex: selectedPageIndex,
      onTap: animateToPage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble,
            size: 22,
          ),
          label: "Quotes",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            size: 22,
          ),
          label: "Add Quote",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(
        //     Icons.chat_bubble_rounded,
        //   ),
        //   label: "My Quotes",
        // ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_pin,
            size: 22,
          ),
          label: "My Quotes",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 22,
          ),
          label: "Settings",
        ),
      ],
    );
  }
}

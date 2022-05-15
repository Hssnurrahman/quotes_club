import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class QuotesBottomNavigationBar {
  SnakeNavigationBar bottomNavigationBar(
    int selectedPageIndex,
    Function(int)? animateToPage,
  ) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.rectangle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      padding: EdgeInsets.only(
        // top: 15,
        bottom: 15,
        left: 15,
        right: 15,
      ),

      ///configuration for SnakeNavigationBar.color
      snakeViewColor: Colors.white,
      selectedItemColor: Colors.grey[800],
      unselectedItemColor: Colors.grey[800],

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

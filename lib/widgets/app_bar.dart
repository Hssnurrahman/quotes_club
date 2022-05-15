import 'package:flutter/material.dart';

class QuotesAppBar {
  AppBar appBar(
    String title,
    bool autoImplyLoading,
  ) {
    return AppBar(
      backgroundColor: Colors.teal,
      automaticallyImplyLeading: autoImplyLoading,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontFamily: "Sansita Swashed Regular",
        ),
      ),
    );
  }
}

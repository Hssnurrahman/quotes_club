import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuotesAppBar {
  AppBar appBar(
    String title,
    bool autoImplyLoading,
      FlatButton flatButton,
  ) {
    return AppBar(
      automaticallyImplyLeading: autoImplyLoading,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontFamily: "Sansita Swashed Regular",
        ),
      ),
      actions: [flatButton],
    );
  }
}

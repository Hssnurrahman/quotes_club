import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
//        For Screen Width <= 300
        subtitle1: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
//        For Screen Width > 400 && Width <= 500
        subtitle2: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
//        For Screen Width > 500 && Width <= 600
        headline1: TextStyle(),
//        For Screen Width > 600 && Width <= 700
        headline2: TextStyle(),
//        For Screen Width > 700 && Width <= 800
        headline3: TextStyle(),
//        For Screen Width > 800 && Width <= 900
        headline4: TextStyle(),
//        For Screen Width > 900 && Width <= 1000
        headline5: TextStyle(),
//        For Screen Width > 1000 && Width <= 1200
        headline6: TextStyle(),
      ),
      color: Colors.teal,
    ),
    cardTheme: CardTheme(
      color: Colors.grey[700],
      shadowColor: Colors.black,
      margin: EdgeInsets.all(
        5,
      ),
      elevation: 5,
    ),
    textTheme: TextTheme(
//        For Screen Width <= 400
      subtitle1: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
//      For Index Color
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
//        For Screen Width > 400 && Width <= 500
      subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
//        For Screen Width > 500 && Width <= 600
      headline1: TextStyle(),
//        For Screen Width > 600 && Width <= 700
      headline2: TextStyle(),
//        For Screen Width > 700 && Width <= 800
      headline3: TextStyle(),
//        For Screen Width > 800 && Width <= 900
      headline4: TextStyle(),
//        For Screen Width > 1000 && Width <= 1100
      headline5: TextStyle(),
//        For Screen Width > 1100 && Width <= 1200
      headline6: TextStyle(),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey,
      indent: 5,
      endIndent: 5,
      thickness: 1,
    ),
    iconTheme: IconThemeData(
      color: Colors.teal,
      size: 15,
    ),
    dialogTheme: DialogTheme(
      elevation: 5,
      contentTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.teal,
      elevation: 5,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.teal,
    ),
    focusColor: Colors.black,
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          13,
        ),
      ),
      elevation: 10,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[600],
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
//        For Screen Width <= 400
        subtitle1: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
//        For Screen Width > 400 && Width <= 500
        subtitle2: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
//        For Screen Width > 500 && Width <= 600
        headline1: TextStyle(),
//        For Screen Width > 600 && Width <= 700
        headline2: TextStyle(),
//        For Screen Width > 700 && Width <= 800
        headline3: TextStyle(),
//        For Screen Width > 800 && Width <= 900
        headline4: TextStyle(),
//        For Screen Width > 900 && Width <= 1000
        headline5: TextStyle(),
//        For Screen Width > 1000 && Width <= 1200
        headline6: TextStyle(),
      ),
      color: Colors.black54,
    ),
    cardTheme: CardTheme(
      color: Colors.blueGrey,
      shadowColor: Colors.grey,
      margin: EdgeInsets.all(
        5,
      ),
      elevation: 5,
    ),
    textTheme: TextTheme(
//        For Screen Width <= 400
      subtitle1: TextStyle(
        color: Colors.white,
        fontSize: 11.3,
      ),
//      For Index Color
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
//        For Screen Width > 400 && Width <= 500
      subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
//        For Screen Width > 500 && Width <= 600
      headline1: TextStyle(),
//        For Screen Width > 600 && Width <= 700
      headline2: TextStyle(),
//        For Screen Width > 700 && Width <= 800
      headline3: TextStyle(),
//        For Screen Width > 800 && Width <= 900
      headline4: TextStyle(),
//        For Screen Width > 1000 && Width <= 1100
      headline5: TextStyle(),
//        For Screen Width > 1100 && Width <= 1200
      headline6: TextStyle(),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.white,
      indent: 10,
      endIndent: 10,
      thickness: 1.5,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 20,
    ),
    dialogTheme: DialogTheme(
      elevation: 5,
      backgroundColor: Colors.black26,
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.black87,
      elevation: 5,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.blueGrey[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          13,
        ),
      ),
      elevation: 10,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}

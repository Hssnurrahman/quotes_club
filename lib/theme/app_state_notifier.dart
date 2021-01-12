import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkModeOn = false;

  bool isEnglish = true;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }

  void updateLanguage(bool isEnglish) {
    this.isEnglish = isEnglish;
  }
}

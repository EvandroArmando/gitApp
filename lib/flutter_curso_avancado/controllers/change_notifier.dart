import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ChangeNotifierController extends ChangeNotifier {
  bool isDarkMode = false;
  void isDarkModeF() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

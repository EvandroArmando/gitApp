import 'package:flutter/material.dart';

class ValueNotifierController extends ValueNotifier<bool> {
  ValueNotifierController() : super(false);
  void isDarkMode() {
    value = !value;
  }
}

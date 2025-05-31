 import 'package:flutter/material.dart';

abstract class Observer {

  void addListener(void Function () listener) {
  }

  void removeListener(void Function ()  listener) {
  }

}
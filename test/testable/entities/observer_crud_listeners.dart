
import 'package:flutter/material.dart';

@visibleForTesting
abstract class ObserverCrudListeners {
  void addListener(void Function() listener) {}

  void removeListener(void Function() listener) {}
}

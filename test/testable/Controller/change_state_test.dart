import 'package:flutter/material.dart';

import '../entities/observer_crud_listeners.dart';


@visibleForTesting
class ChangeStateTest implements ObserverCrudListeners {
  final List<void Function()> _listF = [];
  @override
  void addListener(void Function() listener) {
    if (!_listF.contains(listener)) _listF.add(listener);
  }

  @override
  void removeListener(void Function() listener) {
    if (_listF.contains(listener)) _listF.remove(listener);
  }

  void notifyCallback() {
    for (int i = 0; i < _listF.length; i++) {
      _listF[i].call();
    }
  }
}
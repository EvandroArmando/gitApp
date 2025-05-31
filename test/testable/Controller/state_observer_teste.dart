
import 'package:flutter/material.dart';

import '../../state_observer_state_test.dart';
import '../entities/observer_state_test.dart';
import 'change_state_test.dart';


@visibleForTesting
class StateObserverteste<T> extends ChangeStateTest
    implements ObserverStateTest<T> {
  T _state;

  @override
  T get state => _state;

  set state(T newState) {
    if (newState == _state) return;
    _state = newState;
    notifyCallback();
  }

  StateObserverteste(this._state);
}
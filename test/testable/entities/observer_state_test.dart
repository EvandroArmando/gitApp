import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/controllers/changeState.dart';

@visibleForTesting
abstract class ObserverStateTest<T> extends ChangeState {
  T state;
  ObserverStateTest(this.state);
}

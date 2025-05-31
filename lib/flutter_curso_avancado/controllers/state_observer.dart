import 'dart:async';

import 'package:git_app/flutter_curso_avancado/controllers/changeState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/counterState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/i_observer2.dart';

class StateObserver<T> extends ChangeState implements IObserverState2 {
  T _state;

  @override
  T get state => _state;

  set state(T newState) {
    if (newState == _state) return;
    _state = newState;
    notifyCallback();
  }

  StateObserver(this._state);
}


extension ObserbleStream<T> on StateObserver<T> {
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(state);

    void callback() {
      streamController.add(state);
    }

    addListener(callback);
    return streamController.stream;
  }
}

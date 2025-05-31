import 'package:flutter/widgets.dart';
import 'package:git_app/flutter_curso_avancado/controllers/changeState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/state_observer.dart';

mixin ChangeStateMixin<T extends StatefulWidget> on State<T> {
  final List<ChangeState> _changeStates = [];

  void addChangeState(ChangeState changeState) {
    changeState.addListener(callbacks);
    _changeStates.add(changeState);
    callbacks();
  }

  /// Adiciona um observer de estado desta forma
  /*   void addStateObserver(StateObserver stateObserver) {
    stateObserver.addListener(callbacks);
    _changeStates.add(stateObserver);
    callbacks();
  } */

  StateObserver<T> addStateObserver<T>(T state) {
    final StateObserver<T> stateObserver = StateObserver(state);
    stateObserver.addListener(callbacks);
    _changeStates.add(stateObserver);
    return stateObserver;
  }

  callbacks() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (var changeState in _changeStates) {
      changeState.removeListener(callbacks);
    }
    super.dispose();
  }
}

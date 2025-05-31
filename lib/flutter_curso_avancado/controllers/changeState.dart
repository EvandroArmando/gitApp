import 'package:git_app/flutter_curso_avancado/controllers/observer.dart';

class ChangeState implements Observer {
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

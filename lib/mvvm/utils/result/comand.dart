import 'package:flutter/foundation.dart';
import 'package:git_app/mvvm/utils/result/result.dart';

// Comand 0, não possui parametros de entrada
typedef ComandAction0<Output> = Future<Result<Output>> Function();

// Comand 1,  possui parametros de entrada
typedef ComandAction1<Output , Input > =
    Future<Result<Output>> Function(Input);

abstract class Comand<Output> extends ChangeNotifier {
  bool _running = false;
  bool get running => _running;
  Result<Output>? _result;
  Result<Output>? get result => _result;
  bool get completed => _result is Ok;
  bool get failed => _result is Error;

  Future<void> _execute(ComandAction0<Output> action) async {
    if (_running) return; // se já estiver a correr, não faz nada
    _running = true;
    _result = null; // reseta o resultado
    notifyListeners(); // notifica os ouvintes que o estado mudou
    try {
      _result = await action(); // executa a accao
    } finally {
      _running = false;
      notifyListeners(); // notifica os ouvintes que o estado mudou
    }
  }
}

class Command0<Output> extends Comand<Output> {
  final ComandAction0<Output> action;
  Command0(this.action);
  Future<void> execute() async {
    await _execute(() => action());
  }
}

// Comand 1, possui parametros de entrada e saida
class Command1< Output , Input >
    extends Comand<Output> {
  final ComandAction1<Output, Input> action;
  Command1(this.action);
  Future<void> execute(Input input) async {
    await _execute(() => action(input));
  }
}

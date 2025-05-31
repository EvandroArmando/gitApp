import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/flutter_curso_avancado/controllers/changeState.dart';

void main() {
  group("Testando varias coisas", () {
    test('testando o contador', () async {
      //Arrange
      final _ChangeState changeState = _ChangeState();
      //Act
      changeState.increment();
      //Assert
      print('valor do contador ${changeState.count}');
      expect(changeState.count, 1);
    });
  });
}

class _ChangeState extends ChangeState {
  int count = 0;
  void increment() {
    count++;
    notifyCallback();
  }
}
